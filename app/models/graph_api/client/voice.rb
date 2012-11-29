# encoding: utf-8
# Copyright (c) 2012, mixi, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#  * Neither the name of the mixi, Inc. nor the names of its contributors may
#    be used to endorse or promote products derived from this software without
#    specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#
# = app/models/graph_api/client/voice.rb - Voice API用クラス
#
require_relative 'base'

# == Description
# Voice APIを叩くためのクラス
#
# == Usage
# #ユーザのTokenを渡して初期化する
# token = GraphApi::Client::Token.create_by_user_id([USER_ID])
# token.oauth.set([CONSUMER_KEY], [CONSUMER_SECRET], [REDIRECT_URL])
# token.get!([AUTHORIZATION_CODE])
# voice = GraphApi::Client::Voice.new(token)
#
# #つぶやきを投稿する
# res = voice.post_voice(status)
#
# == See also
# mixi Developer Center  Voice API
# http://developer.mixi.co.jp/connect/mixi_graph_api/mixi_io_spec_top/voice-api/

class GraphApi::Client::Voice < GraphApi::Client::Base

  ENDPOINT_PREFIX = '/2/voice'

  # つぶやきの投稿
  # ---
  # *Arguments*
  # (required) status:  String
  # (optional) options: Hash
  # *Returns*:: JSONレスポンス: Hash
  def post_voice(status, options={})
    endpoint = "#{ENDPOINT_PREFIX}/statuses"
    headers = {'Content-Type' => 'application/x-www-form-urlencoded'}
    body = { status: status }.merge(options).map do |key, value|
        CGI.escape("#{key}") + '=' + CGI.escape("#{value}")
    end.join('&')
    post(endpoint, { headers: headers, body: body })
  end

end #Voice