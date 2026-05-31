
zero_sign_extension_32bit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40048d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd96(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x4003cb <.text+0x8b>
               	leaq	0xfd72(%rip), %rdi      # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfd4f(%rip), %rdi      # 0x410128
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd3d(%rip), %rsi      # 0x41012e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd2c(%rip), %r9       # 0x410135
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4014b7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400459 <.text+0x119>
               	leaq	0xfccf(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400459 <.text+0x119>
               	leaq	0xfcb0(%rip), %r12      # 0x410110
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$-0x1, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xc0(%rsp)
               	jmp	0x4004d5 <.text+0x195>
               	movq	0xc0(%rsp), %r8
               	cmpq	$-0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x40055c <.text+0x21c>
               	jmp	0x400513 <.text+0x1d3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4004d5 <.text+0x195>
               	jmp	0x400561 <.text+0x221>
               	leaq	0xfc46(%rip), %r8       # 0x410160
               	movl	$0x1, %r14d
               	movl	%r14d, (%r8)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfc2d(%rip), %r15      # 0x410168
               	movl	$0x1b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40055c <.text+0x21c>
               	jmp	0x4004fe <.text+0x1be>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40060d <.text+0x2cd>
               	jmp	0x4005c9 <.text+0x289>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400561 <.text+0x221>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	0x400612 <.text+0x2d2>
               	leaq	0xfb90(%rip), %r12      # 0x410160
               	movl	$0x2, %r14d
               	movl	%r14d, (%r12)
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfb92(%rip), %r15      # 0x41017e
               	movl	$0x1c, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40060d <.text+0x2cd>
               	jmp	0x40058d <.text+0x24d>
               	movq	0xb0(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40069a <.text+0x35a>
               	jmp	0x400652 <.text+0x312>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400612 <.text+0x2d2>
               	jmp	0x40069f <.text+0x35f>
               	leaq	0xfb07(%rip), %r15      # 0x410160
               	movl	$0x3, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb1a(%rip), %r15      # 0x410194
               	movl	$0x20, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40069a <.text+0x35a>
               	jmp	0x40063d <.text+0x2fd>
               	movq	0xb8(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rbx
               	cmpq	%r11, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400762 <.text+0x422>
               	jmp	0x400719 <.text+0x3d9>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40069f <.text+0x35f>
               	movabsq	$-0x7, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r14
               	movslq	%r14d, %r14
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r14, %r10
               	movq	%r10, 0xa0(%rsp)
               	jmp	0x400767 <.text+0x427>
               	leaq	0xfa40(%rip), %rbx      # 0x410160
               	movl	$0x4, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfa69(%rip), %rbx      # 0x4101aa
               	movl	$0x21, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400762 <.text+0x422>
               	jmp	0x4006d6 <.text+0x396>
               	movq	0xa0(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	movq	%r14, %rbx
               	cmpq	%r11, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400817 <.text+0x4d7>
               	jmp	0x4007cf <.text+0x48f>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400767 <.text+0x427>
               	movq	0xa0(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	0x40081c <.text+0x4dc>
               	leaq	0xf98a(%rip), %rbx      # 0x410160
               	movl	$0xa, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf9ca(%rip), %rbx      # 0x4101c0
               	movl	$0x28, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400817 <.text+0x4d7>
               	jmp	0x40079e <.text+0x45e>
               	movq	0x98(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$-0x7, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4008c1 <.text+0x581>
               	jmp	0x400879 <.text+0x539>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40081c <.text+0x4dc>
               	movq	0xa8(%rsp), %rax
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	0x4008c6 <.text+0x586>
               	leaq	0xf8e0(%rip), %rbx      # 0x410160
               	movl	$0xb, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf936(%rip), %rbx      # 0x4101d6
               	movl	$0x2a, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4008c1 <.text+0x581>
               	jmp	0x400848 <.text+0x508>
               	movq	0x90(%rsp), %rax
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400971 <.text+0x631>
               	jmp	0x400929 <.text+0x5e9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4008c6 <.text+0x586>
               	movl	$0xf4240, %eax          # imm = 0xF4240
               	movl	$0xbb8, %r12d           # imm = 0xBB8
               	movslq	%eax, %rbx
               	movslq	%r12d, %rax
               	movq	%rbx, %r12
               	imulq	%rax, %r12
               	movslq	%r12d, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	0x400976 <.text+0x636>
               	leaq	0xf830(%rip), %rax      # 0x410160
               	movl	$0xc, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf89c(%rip), %rbx      # 0x4101ec
               	movl	$0x30, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400971 <.text+0x631>
               	jmp	0x4008f1 <.text+0x5b1>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4009ff <.text+0x6bf>
               	jmp	0x4009b7 <.text+0x677>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400976 <.text+0x636>
               	jmp	0x400a04 <.text+0x6c4>
               	leaq	0xf7a2(%rip), %rbx      # 0x410160
               	movl	$0x14, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf824(%rip), %rbx      # 0x410202
               	movl	$0x3a, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4009ff <.text+0x6bf>
               	jmp	0x4009a2 <.text+0x662>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400abd <.text+0x77d>
               	jmp	0x400a74 <.text+0x734>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a04 <.text+0x6c4>
               	movl	$0x10000, %eax          # imm = 0x10000
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	movq	%r15, %rax
               	imulq	%r14, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	0x400ac2 <.text+0x782>
               	leaq	0xf6e5(%rip), %r14      # 0x410160
               	movl	$0x15, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf77c(%rip), %r14      # 0x410218
               	movl	$0x3b, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400abd <.text+0x77d>
               	jmp	0x400a30 <.text+0x6f0>
               	movq	0x80(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400b52 <.text+0x812>
               	jmp	0x400b09 <.text+0x7c9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400ac2 <.text+0x782>
               	jmp	0x400b57 <.text+0x817>
               	leaq	0xf650(%rip), %r15      # 0x410160
               	movl	$0x16, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf6fd(%rip), %r15      # 0x41022e
               	movl	$0x40, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400b52 <.text+0x812>
               	jmp	0x400af4 <.text+0x7b4>
               	movq	0x80(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400bff <.text+0x8bf>
               	jmp	0x400bb7 <.text+0x877>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400b57 <.text+0x817>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	movq	%rbx, %r10
               	shrq	$0x1, %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	0x400c04 <.text+0x8c4>
               	leaq	0xf5a2(%rip), %r12      # 0x410160
               	movl	$0x17, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf665(%rip), %r12      # 0x410244
               	movl	$0x41, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400bff <.text+0x8bf>
               	jmp	0x400b89 <.text+0x849>
               	movq	0x78(%rsp), %rbx
               	cmpq	$0x40000000, %rbx       # imm = 0x40000000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400caa <.text+0x96a>
               	jmp	0x400c62 <.text+0x922>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400c04 <.text+0x8c4>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	movq	%r14, %rax
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	0x400caf <.text+0x96f>
               	leaq	0xf4f7(%rip), %rbx      # 0x410160
               	movl	$0x1e, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf5d1(%rip), %rbx      # 0x41025a
               	movl	$0x4a, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400caa <.text+0x96a>
               	jmp	0x400c2a <.text+0x8ea>
               	movq	0x70(%rsp), %rax
               	cmpq	$0x23456780, %rax       # imm = 0x23456780
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400d56 <.text+0xa16>
               	jmp	0x400d0e <.text+0x9ce>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400caf <.text+0x96f>
               	xorq	%rax, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	movq	%r15, %rax
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x400d5b <.text+0xa1b>
               	leaq	0xf44b(%rip), %rax      # 0x410160
               	movl	$0x1f, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf53b(%rip), %rbx      # 0x410270
               	movl	$0x4f, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400d56 <.text+0xa16>
               	jmp	0x400cd5 <.text+0x995>
               	movq	0x68(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400dfc <.text+0xabc>
               	jmp	0x400db4 <.text+0xa74>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400d5b <.text+0xa1b>
               	leaq	0xf502(%rip), %r15      # 0x41029c
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x4014c3 <atoi>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x400e01 <.text+0xac1>
               	leaq	0xf3a5(%rip), %rax      # 0x410160
               	movl	$0x20, %r15d
               	movl	%r15d, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf4ab(%rip), %rbx      # 0x410286
               	movl	$0x54, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400dfc <.text+0xabc>
               	jmp	0x400d83 <.text+0xa43>
               	movq	0x60(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$-0x7fffffff, %r15      # imm = 0x80000001
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400e87 <.text+0xb47>
               	jmp	0x400e3f <.text+0xaff>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400e01 <.text+0xac1>
               	jmp	0x400e8c <.text+0xb4c>
               	leaq	0xf31a(%rip), %rbx      # 0x410160
               	movl	$0x28, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf442(%rip), %rbx      # 0x4102a8
               	movl	$0x5d, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400e87 <.text+0xb47>
               	jmp	0x400e2a <.text+0xaea>
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400f58 <.text+0xc18>
               	jmp	0x400f0e <.text+0xbce>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400e8c <.text+0xb4c>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %r12
               	movslq	%r12d, %r12
               	movq	0x58(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	%r12, %rax
               	addq	%r15, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	0x400f5d <.text+0xc1d>
               	leaq	0xf24b(%rip), %r12      # 0x410160
               	movl	$0x29, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf387(%rip), %r12      # 0x4102be
               	movl	$0x5e, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400f58 <.text+0xc18>
               	jmp	0x400eb5 <.text+0xb75>
               	movq	0x50(%rsp), %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40100a <.text+0xcca>
               	jmp	0x400fc2 <.text+0xc82>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400f5d <.text+0xc1d>
               	movq	0x48(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	%rax, %rbx
               	subq	%r14, %rbx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	0x40100f <.text+0xccf>
               	leaq	0xf197(%rip), %rax      # 0x410160
               	movl	$0x32, %r15d
               	movl	%r15d, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf2eb(%rip), %rbx      # 0x4102d4
               	movl	$0x68, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40100a <.text+0xcca>
               	jmp	0x400f83 <.text+0xc43>
               	movq	0x40(%rsp), %rbx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40109f <.text+0xd5f>
               	jmp	0x401057 <.text+0xd17>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40100f <.text+0xccf>
               	movl	$0x12345678, %r10d      # imm = 0x12345678
               	movq	%r10, 0x38(%rsp)
               	jmp	0x4010a4 <.text+0xd64>
               	leaq	0xf102(%rip), %rbx      # 0x410160
               	movl	$0x33, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf26c(%rip), %rbx      # 0x4102ea
               	movl	$0x6c, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40109f <.text+0xd5f>
               	jmp	0x401037 <.text+0xcf7>
               	movq	0x38(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$0x12345678, %r15       # imm = 0x12345678
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401137 <.text+0xdf7>
               	jmp	0x4010ef <.text+0xdaf>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4010a4 <.text+0xd64>
               	movq	0x38(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	0x40113c <.text+0xdfc>
               	leaq	0xf06a(%rip), %rbx      # 0x410160
               	movl	$0x3c, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf1ea(%rip), %rbx      # 0x410300
               	movl	$0x73, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401137 <.text+0xdf7>
               	jmp	0x4010cd <.text+0xd8d>
               	movq	0x30(%rsp), %r14
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4011dc <.text+0xe9c>
               	jmp	0x401193 <.text+0xe53>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40113c <.text+0xdfc>
               	movabsq	$-0x77359400, %r10      # imm = 0x88CA6C00
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x20(%rsp)
               	jmp	0x4011e1 <.text+0xea1>
               	leaq	0xefc6(%rip), %r14      # 0x410160
               	movl	$0x3d, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf15b(%rip), %r14      # 0x410316
               	movl	$0x75, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4011dc <.text+0xe9c>
               	jmp	0x401162 <.text+0xe22>
               	movq	0x20(%rsp), %r14
               	cmpq	$-0x77359400, %r14      # imm = 0x88CA6C00
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401264 <.text+0xf24>
               	jmp	0x40121c <.text+0xedc>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4011e1 <.text+0xea1>
               	jmp	0x401269 <.text+0xf29>
               	leaq	0xef3d(%rip), %r14      # 0x410160
               	movl	$0x3e, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf0e8(%rip), %r14      # 0x41032c
               	movl	$0x7a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401264 <.text+0xf24>
               	jmp	0x401207 <.text+0xec7>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x77359400, %rax      # imm = 0x88CA6C00
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401307 <.text+0xfc7>
               	jmp	0x4012be <.text+0xf7e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401269 <.text+0xf29>
               	leaq	0xeeb7(%rip), %rax      # 0x410160
               	movslq	(%rax), %r15
               	cmpq	$0x0, %r15
               	jne	0x401345 <.text+0x1005>
               	jmp	0x40130c <.text+0xfcc>
               	leaq	0xee9b(%rip), %rbx      # 0x410160
               	movl	$0x3f, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf05c(%rip), %rbx      # 0x410342
               	movl	$0x7b, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4014bd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401307 <.text+0xfc7>
               	jmp	0x401292 <.text+0xf52>
               	leaq	0xf045(%rip), %r12      # 0x410358
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4014c9 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	0xee14(%rip), %r12      # 0x410160
               	movslq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
