
integer_boundary_c99.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40044d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfdce(%rip), %r9       # 0x410108
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40038b <.text+0x8b>
               	leaq	0xfdaa(%rip), %rdi      # 0x410108
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
               	leaq	0xfd87(%rip), %rdi      # 0x410120
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd75(%rip), %rsi      # 0x410126
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd64(%rip), %r9       # 0x41012d
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
               	callq	0x402627 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400419 <.text+0x119>
               	leaq	0xfd07(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400419 <.text+0x119>
               	leaq	0xfce8(%rip), %r12      # 0x410108
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
               	subq	$0x240, %rsp            # imm = 0x240
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	0x400470 <.text+0x170>
               	movl	$0x1, %r11d
               	cmpq	$0x0, %r11
               	jne	0x4004e5 <.text+0x1e5>
               	jmp	0x40049d <.text+0x19d>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400470 <.text+0x170>
               	jmp	0x4004ea <.text+0x1ea>
               	leaq	0xfcb4(%rip), %r11      # 0x410158
               	movl	$0x64, %ebx
               	movl	%ebx, (%r11)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfc9c(%rip), %r15      # 0x410160
               	movl	$0x36, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4004e5 <.text+0x1e5>
               	jmp	0x400488 <.text+0x188>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40055d <.text+0x25d>
               	jmp	0x400516 <.text+0x216>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4004ea <.text+0x1ea>
               	jmp	0x400562 <.text+0x262>
               	leaq	0xfc3b(%rip), %rax      # 0x410158
               	movl	$0x65, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc3f(%rip), %r14      # 0x41017b
               	movl	$0x37, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40055d <.text+0x25d>
               	jmp	0x400501 <.text+0x201>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4005d5 <.text+0x2d5>
               	jmp	0x40058e <.text+0x28e>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400562 <.text+0x262>
               	jmp	0x4005da <.text+0x2da>
               	leaq	0xfbc3(%rip), %rax      # 0x410158
               	movl	$0x66, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfbe2(%rip), %r15      # 0x410196
               	movl	$0x38, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4005d5 <.text+0x2d5>
               	jmp	0x400579 <.text+0x279>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40064d <.text+0x34d>
               	jmp	0x400606 <.text+0x306>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4005da <.text+0x2da>
               	jmp	0x400652 <.text+0x352>
               	leaq	0xfb4b(%rip), %rax      # 0x410158
               	movl	$0x67, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfb85(%rip), %r14      # 0x4101b1
               	movl	$0x39, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40064d <.text+0x34d>
               	jmp	0x4005f1 <.text+0x2f1>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4006c5 <.text+0x3c5>
               	jmp	0x40067e <.text+0x37e>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400652 <.text+0x352>
               	jmp	0x4006ca <.text+0x3ca>
               	leaq	0xfad3(%rip), %rax      # 0x410158
               	movl	$0x68, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb28(%rip), %r15      # 0x4101cc
               	movl	$0x3a, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4006c5 <.text+0x3c5>
               	jmp	0x400669 <.text+0x369>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40073d <.text+0x43d>
               	jmp	0x4006f6 <.text+0x3f6>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4006ca <.text+0x3ca>
               	jmp	0x400742 <.text+0x442>
               	leaq	0xfa5b(%rip), %rax      # 0x410158
               	movl	$0x69, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfacb(%rip), %r14      # 0x4101e7
               	movl	$0x3b, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40073d <.text+0x43d>
               	jmp	0x4006e1 <.text+0x3e1>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4007b5 <.text+0x4b5>
               	jmp	0x40076e <.text+0x46e>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400742 <.text+0x442>
               	jmp	0x4007ba <.text+0x4ba>
               	leaq	0xf9e3(%rip), %rax      # 0x410158
               	movl	$0x6a, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfa6e(%rip), %r15      # 0x410202
               	movl	$0x3c, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4007b5 <.text+0x4b5>
               	jmp	0x400759 <.text+0x459>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x400836 <.text+0x536>
               	jmp	0x4007ef <.text+0x4ef>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4007ba <.text+0x4ba>
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	jmp	0x40083b <.text+0x53b>
               	leaq	0xf962(%rip), %rax      # 0x410158
               	movl	$0x6b, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfa08(%rip), %r14      # 0x41021d
               	movl	$0x3d, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400836 <.text+0x536>
               	jmp	0x4007d1 <.text+0x4d1>
               	movzbq	-0x8(%rbp), %rax
               	movq	%rax, %r12
               	xorq	$0xff, %r12
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4008e6 <.text+0x5e6>
               	jmp	0x40089d <.text+0x59d>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40083b <.text+0x53b>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movb	%r12b, (%rax)
               	jmp	0x4008eb <.text+0x5eb>
               	leaq	0xf8b4(%rip), %r12      # 0x410158
               	movl	$0x6e, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf973(%rip), %r12      # 0x410238
               	movl	$0x42, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4008e6 <.text+0x5e6>
               	jmp	0x400873 <.text+0x573>
               	movzbq	-0x8(%rbp), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40098d <.text+0x68d>
               	jmp	0x400944 <.text+0x644>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4008eb <.text+0x5eb>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$-0x1, %r12
               	movb	%r12b, (%rax)
               	jmp	0x400992 <.text+0x692>
               	leaq	0xf80d(%rip), %r12      # 0x410158
               	movl	$0x6f, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf8e7(%rip), %r12      # 0x410253
               	movl	$0x44, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40098d <.text+0x68d>
               	jmp	0x40091a <.text+0x61a>
               	movzbq	-0x8(%rbp), %r12
               	movq	%r12, %r15
               	xorq	$0xff, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a36 <.text+0x736>
               	jmp	0x4009ee <.text+0x6ee>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400992 <.text+0x692>
               	movl	$0x7f, %r10d
               	movq	%r10, 0xf8(%rsp)
               	jmp	0x400a3b <.text+0x73b>
               	leaq	0xf763(%rip), %r15      # 0x410158
               	movl	$0x70, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf859(%rip), %r15      # 0x41026e
               	movl	$0x46, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400a36 <.text+0x736>
               	jmp	0x4009cb <.text+0x6cb>
               	movq	0xf8(%rsp), %r12
               	movsbq	%r12b, %r12
               	cmpq	$0x7f, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400ad3 <.text+0x7d3>
               	jmp	0x400a8b <.text+0x78b>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a3b <.text+0x73b>
               	movabsq	$-0x80, %rax
               	movb	%al, -0x18(%rbp)
               	jmp	0x400ad8 <.text+0x7d8>
               	leaq	0xf6c6(%rip), %r15      # 0x410158
               	movl	$0x71, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf7d6(%rip), %r15      # 0x410289
               	movl	$0x49, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400ad3 <.text+0x7d3>
               	jmp	0x400a68 <.text+0x768>
               	movsbq	-0x18(%rbp), %rax
               	cmpq	$-0x80, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400b71 <.text+0x871>
               	jmp	0x400b28 <.text+0x828>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400ad8 <.text+0x7d8>
               	leaq	-0x18(%rbp), %rax
               	movsbq	(%rax), %r12
               	movq	%r12, %rbx
               	addq	$-0x1, %rbx
               	movb	%bl, (%rax)
               	jmp	0x400b76 <.text+0x876>
               	leaq	0xf629(%rip), %rbx      # 0x410158
               	movl	$0x72, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf754(%rip), %rbx      # 0x4102a4
               	movl	$0x4b, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400b71 <.text+0x871>
               	jmp	0x400afe <.text+0x7fe>
               	movsbq	-0x18(%rbp), %rbx
               	movq	%rbx, %r12
               	andq	$0xff, %r12
               	movq	%r12, %rbx
               	xorq	$0x7f, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400c20 <.text+0x920>
               	jmp	0x400bd7 <.text+0x8d7>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400b76 <.text+0x876>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movw	%ax, -0x20(%rbp)
               	jmp	0x400c25 <.text+0x925>
               	leaq	0xf57a(%rip), %rbx      # 0x410158
               	movl	$0x73, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf6c0(%rip), %rbx      # 0x4102bf
               	movl	$0x4d, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400c20 <.text+0x920>
               	jmp	0x400bb9 <.text+0x8b9>
               	movzwq	-0x20(%rbp), %rax
               	movq	%rax, %r12
               	xorq	$0xffff, %r12           # imm = 0xFFFF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cd2 <.text+0x9d2>
               	jmp	0x400c88 <.text+0x988>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400c25 <.text+0x925>
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movw	%r12w, (%rax)
               	jmp	0x400cd7 <.text+0x9d7>
               	leaq	0xf4c9(%rip), %r12      # 0x410158
               	movl	$0x78, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf629(%rip), %r12      # 0x4102da
               	movl	$0x53, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400cd2 <.text+0x9d2>
               	jmp	0x400c5d <.text+0x95d>
               	movzwq	-0x20(%rbp), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d82 <.text+0xa82>
               	jmp	0x400d38 <.text+0xa38>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400cd7 <.text+0x9d7>
               	xorq	%rax, %rax
               	movw	%ax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movzwq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$-0x1, %r12
               	movw	%r12w, (%r15)
               	jmp	0x400d87 <.text+0xa87>
               	leaq	0xf419(%rip), %r12      # 0x410158
               	movl	$0x79, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf594(%rip), %r12      # 0x4102f5
               	movl	$0x55, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400d82 <.text+0xa82>
               	jmp	0x400d06 <.text+0xa06>
               	movzwq	-0x20(%rbp), %r12
               	movq	%r12, %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400e2c <.text+0xb2c>
               	jmp	0x400de3 <.text+0xae3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d87 <.text+0xa87>
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	movq	%r10, 0xf0(%rsp)
               	jmp	0x400e31 <.text+0xb31>
               	leaq	0xf36e(%rip), %rax      # 0x410158
               	movl	$0x7a, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf505(%rip), %rbx      # 0x410310
               	movl	$0x58, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400e2c <.text+0xb2c>
               	jmp	0x400dc0 <.text+0xac0>
               	movq	0xf0(%rsp), %r12
               	movswq	%r12w, %r12
               	cmpq	$0x7fff, %r12           # imm = 0x7FFF
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400ecd <.text+0xbcd>
               	jmp	0x400e85 <.text+0xb85>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400e31 <.text+0xb31>
               	movabsq	$-0x8000, %r10          # imm = 0x8000
               	movq	%r10, 0xe8(%rsp)
               	jmp	0x400ed2 <.text+0xbd2>
               	leaq	0xf2cc(%rip), %rbx      # 0x410158
               	movl	$0x7b, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf47f(%rip), %rbx      # 0x41032b
               	movl	$0x5b, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400ecd <.text+0xbcd>
               	jmp	0x400e5e <.text+0xb5e>
               	movq	0xe8(%rsp), %r14
               	movswq	%r14w, %r14
               	cmpq	$-0x8000, %r14          # imm = 0x8000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400f7a <.text+0xc7a>
               	jmp	0x400f32 <.text+0xc32>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400ed2 <.text+0xbd2>
               	movq	0xe8(%rsp), %rax
               	movswq	%ax, %rax
               	movq	%rax, %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xe0(%rsp)
               	jmp	0x400f7f <.text+0xc7f>
               	leaq	0xf21f(%rip), %rbx      # 0x410158
               	movl	$0x7c, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf3ed(%rip), %rbx      # 0x410346
               	movl	$0x5d, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400f7a <.text+0xc7a>
               	jmp	0x400eff <.text+0xbff>
               	movq	0xe0(%rsp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rbx
               	xorq	$0x8000, %rbx           # imm = 0x8000
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401032 <.text+0xd32>
               	jmp	0x400fea <.text+0xcea>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400f7f <.text+0xc7f>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movslq	%eax, %r12
               	movswq	%r12w, %r10
               	movq	%r10, 0xd8(%rsp)
               	jmp	0x401037 <.text+0xd37>
               	leaq	0xf167(%rip), %rbx      # 0x410158
               	movl	$0x7d, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf350(%rip), %rbx      # 0x410361
               	movl	$0x5f, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401032 <.text+0xd32>
               	jmp	0x400fc1 <.text+0xcc1>
               	movq	0xd8(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4010d7 <.text+0xdd7>
               	jmp	0x40108f <.text+0xd8f>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401037 <.text+0xd37>
               	movabsq	$-0x2a, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0xd0(%rsp)
               	jmp	0x4010dc <.text+0xddc>
               	leaq	0xf0c2(%rip), %rbx      # 0x410158
               	movl	$0x7e, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf2c6(%rip), %rbx      # 0x41037c
               	movl	$0x64, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4010d7 <.text+0xdd7>
               	jmp	0x401064 <.text+0xd64>
               	movq	0xd0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x2a, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40118a <.text+0xe8a>
               	jmp	0x401142 <.text+0xe42>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4010dc <.text+0xddc>
               	movl	$0xffff, %r10d          # imm = 0xFFFF
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xc0(%rsp)
               	jmp	0x40118f <.text+0xe8f>
               	leaq	0xf00f(%rip), %rbx      # 0x410158
               	movl	$0x7f, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf22e(%rip), %rbx      # 0x410397
               	movl	$0x69, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40118a <.text+0xe8a>
               	jmp	0x401108 <.text+0xe08>
               	movq	0xc0(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movq	%rbx, %r12
               	xorq	$0xffff, %r12           # imm = 0xFFFF
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401231 <.text+0xf31>
               	jmp	0x4011e8 <.text+0xee8>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40118f <.text+0xe8f>
               	jmp	0x401236 <.text+0xf36>
               	leaq	0xef69(%rip), %r12      # 0x410158
               	movl	$0x80, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf1a2(%rip), %r12      # 0x4103b2
               	movl	$0x6e, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401231 <.text+0xf31>
               	jmp	0x4011d3 <.text+0xed3>
               	movq	0xc8(%rsp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0xffff, %rax           # imm = 0xFFFF
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4012cb <.text+0xfcb>
               	jmp	0x401283 <.text+0xf83>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401236 <.text+0xf36>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x70(%rbp)
               	jmp	0x4012d0 <.text+0xfd0>
               	leaq	0xeece(%rip), %r14      # 0x410158
               	movl	$0x81, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf123(%rip), %r14      # 0x4103cd
               	movl	$0x70, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4012cb <.text+0xfcb>
               	jmp	0x401266 <.text+0xf66>
               	movl	-0x70(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %r15
               	cmpq	%r11, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40136a <.text+0x106a>
               	jmp	0x401322 <.text+0x1022>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4012d0 <.text+0xfd0>
               	leaq	-0x70(%rbp), %rax
               	movl	(%rax), %r12d
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movl	%r15d, (%rax)
               	jmp	0x40136f <.text+0x106f>
               	leaq	0xee2f(%rip), %r15      # 0x410158
               	movl	$0x82, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf09f(%rip), %r15      # 0x4103e8
               	movl	$0x76, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40136a <.text+0x106a>
               	jmp	0x4012f9 <.text+0xff9>
               	movl	-0x70(%rbp), %r15d
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401416 <.text+0x1116>
               	jmp	0x4013ce <.text+0x10ce>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40136f <.text+0x106f>
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %r12
               	movl	(%r12), %eax
               	movq	%rax, %r15
               	addq	$-0x1, %r15
               	movl	%r15d, (%r12)
               	jmp	0x40141b <.text+0x111b>
               	leaq	0xed83(%rip), %r15      # 0x410158
               	movl	$0x83, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf00e(%rip), %r15      # 0x410403
               	movl	$0x78, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401416 <.text+0x1116>
               	jmp	0x40139d <.text+0x109d>
               	movl	-0x70(%rbp), %r15d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r15, %rax
               	cmpq	%r11, %r15
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4014af <.text+0x11af>
               	jmp	0x401468 <.text+0x1168>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40141b <.text+0x111b>
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	jmp	0x4014b4 <.text+0x11b4>
               	leaq	0xece9(%rip), %rax      # 0x410158
               	movl	$0x84, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xef90(%rip), %r14      # 0x41041e
               	movl	$0x7b, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4014af <.text+0x11af>
               	jmp	0x401445 <.text+0x1145>
               	movq	0xb8(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$0x7fffffff, %r15       # imm = 0x7FFFFFFF
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401552 <.text+0x1252>
               	jmp	0x40150a <.text+0x120a>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4014b4 <.text+0x11b4>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movslq	%eax, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	0x401557 <.text+0x1257>
               	leaq	0xec47(%rip), %r14      # 0x410158
               	movl	$0x85, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xef07(%rip), %r14      # 0x410439
               	movl	$0x7e, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401552 <.text+0x1252>
               	jmp	0x4014e0 <.text+0x11e0>
               	movq	0xb0(%rsp), %rbx
               	movslq	%ebx, %rbx
               	cmpq	$-0x80000000, %rbx      # imm = 0x80000000
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4015f4 <.text+0x12f4>
               	jmp	0x4015ab <.text+0x12ab>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401557 <.text+0x1257>
               	movq	0xb0(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	0x4015f9 <.text+0x12f9>
               	leaq	0xeba6(%rip), %r14      # 0x410158
               	movl	$0x86, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xee81(%rip), %r14      # 0x410454
               	movl	$0x80, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4015f4 <.text+0x12f4>
               	jmp	0x401583 <.text+0x1283>
               	movq	0xa8(%rsp), %r12
               	cmpq	$-0x80000000, %r12      # imm = 0x80000000
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401693 <.text+0x1393>
               	jmp	0x40164a <.text+0x134a>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4015f9 <.text+0x12f9>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	jmp	0x401698 <.text+0x1398>
               	leaq	0xeb07(%rip), %r12      # 0x410158
               	movl	$0x87, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xedfd(%rip), %r12      # 0x41046f
               	movl	$0x86, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401693 <.text+0x1393>
               	jmp	0x401622 <.text+0x1322>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401727 <.text+0x1427>
               	jmp	0x4016e4 <.text+0x13e4>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401698 <.text+0x1398>
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	0x40172c <.text+0x142c>
               	leaq	0xea6d(%rip), %rax      # 0x410158
               	movl	$0x88, %r15d
               	movl	%r15d, (%rax)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xed7e(%rip), %r12      # 0x41048a
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401727 <.text+0x1427>
               	jmp	0x4016be <.text+0x13be>
               	movq	-0x98(%rbp), %rax
               	cmpq	$-0x1, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4017ca <.text+0x14ca>
               	jmp	0x401780 <.text+0x1480>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40172c <.text+0x142c>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	jmp	0x4017cf <.text+0x14cf>
               	leaq	0xe9d1(%rip), %r12      # 0x410158
               	movl	$0x8c, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xecfc(%rip), %r12      # 0x4104a5
               	movl	$0x8e, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4017ca <.text+0x14ca>
               	jmp	0x401754 <.text+0x1454>
               	movq	-0x98(%rbp), %r12
               	cmpq	$0x0, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40186c <.text+0x156c>
               	jmp	0x401823 <.text+0x1523>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4017cf <.text+0x14cf>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %r12
               	movq	%r12, %r14
               	addq	$-0x1, %r14
               	movq	%r14, (%rax)
               	jmp	0x401871 <.text+0x1571>
               	leaq	0xe92e(%rip), %r14      # 0x410158
               	movl	$0x8d, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xec75(%rip), %r14      # 0x4104c0
               	movl	$0x90, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40186c <.text+0x156c>
               	jmp	0x4017f7 <.text+0x14f7>
               	movq	-0x98(%rbp), %r14
               	cmpq	$-0x1, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40190a <.text+0x160a>
               	jmp	0x4018c0 <.text+0x15c0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401871 <.text+0x1571>
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, 0xa0(%rsp)
               	jmp	0x40190f <.text+0x160f>
               	leaq	0xe891(%rip), %r12      # 0x410158
               	movl	$0x8e, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xebf2(%rip), %r12      # 0x4104db
               	movl	$0x92, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40190a <.text+0x160a>
               	jmp	0x401899 <.text+0x1599>
               	movq	0xa0(%rsp), %r14
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4019ad <.text+0x16ad>
               	jmp	0x401965 <.text+0x1665>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40190f <.text+0x160f>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	0x4019b2 <.text+0x16b2>
               	leaq	0xe7ec(%rip), %r14      # 0x410158
               	movl	$0x8f, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xeb6a(%rip), %r14      # 0x4104f6
               	movl	$0x95, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4019ad <.text+0x16ad>
               	jmp	0x40193e <.text+0x163e>
               	movq	0x98(%rsp), %r15
               	sarq	$0x1, %r15
               	cmpq	$-0x1, %r15
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401a4e <.text+0x174e>
               	jmp	0x401a06 <.text+0x1706>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4019b2 <.text+0x16b2>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, 0x90(%rsp)
               	jmp	0x401a53 <.text+0x1753>
               	leaq	0xe74b(%rip), %r14      # 0x410158
               	movl	$0x90, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xeae3(%rip), %r14      # 0x410511
               	movl	$0x9a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401a4e <.text+0x174e>
               	jmp	0x4019df <.text+0x16df>
               	movq	0x90(%rsp), %rbx
               	shrq	$0x1, %rbx
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%rbx, %r14
               	cmpq	%r11, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401af9 <.text+0x17f9>
               	jmp	0x401ab0 <.text+0x17b0>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401a53 <.text+0x1753>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	0x401afe <.text+0x17fe>
               	leaq	0xe6a1(%rip), %r14      # 0x410158
               	movl	$0x91, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xea54(%rip), %r14      # 0x41052c
               	movl	$0x9d, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401af9 <.text+0x17f9>
               	jmp	0x401a89 <.text+0x1789>
               	movq	0x88(%rsp), %r12
               	shrq	$0x20, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r12, %r14
               	cmpq	%r11, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401bb0 <.text+0x18b0>
               	jmp	0x401b68 <.text+0x1868>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401afe <.text+0x17fe>
               	movabsq	$-0x12c, %r10           # imm = 0xFED4
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movsbq	%r15b, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	0x401bb5 <.text+0x18b5>
               	leaq	0xe5e9(%rip), %r14      # 0x410158
               	movl	$0x92, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe9b8(%rip), %r14      # 0x410547
               	movl	$0xa0, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401bb0 <.text+0x18b0>
               	jmp	0x401b30 <.text+0x1830>
               	movq	0x80(%rsp), %r14
               	movsbq	%r14b, %r14
               	movl	$0xd4, %r15d
               	movsbq	%r15b, %r15
               	cmpq	%r15, %r14
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401c45 <.text+0x1945>
               	jmp	0x401bfd <.text+0x18fd>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401bb5 <.text+0x18b5>
               	jmp	0x401c4a <.text+0x194a>
               	leaq	0xe554(%rip), %rax      # 0x410158
               	movl	$0x96, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe93d(%rip), %r15      # 0x410562
               	movl	$0xa9, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401c45 <.text+0x1945>
               	jmp	0x401be8 <.text+0x18e8>
               	movq	0x80(%rsp), %rax
               	movsbq	%al, %rax
               	cmpq	$-0x2c, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401cec <.text+0x19ec>
               	jmp	0x401ca3 <.text+0x19a3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401c4a <.text+0x194a>
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	0x401cf1 <.text+0x19f1>
               	leaq	0xe4ae(%rip), %rbx      # 0x410158
               	movl	$0x97, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe8b2(%rip), %rbx      # 0x41057d
               	movl	$0xaa, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401cec <.text+0x19ec>
               	jmp	0x401c77 <.text+0x1977>
               	movq	0x70(%rsp), %rax
               	andq	$0xff, %rax
               	movq	%rax, %rbx
               	xorq	$0xd4, %rbx
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401d8d <.text+0x1a8d>
               	jmp	0x401d45 <.text+0x1a45>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401cf1 <.text+0x19f1>
               	jmp	0x401d92 <.text+0x1a92>
               	leaq	0xe40c(%rip), %rbx      # 0x410158
               	movl	$0x98, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe82c(%rip), %rbx      # 0x410598
               	movl	$0xaf, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401d8d <.text+0x1a8d>
               	jmp	0x401d30 <.text+0x1a30>
               	movq	0x70(%rsp), %rax
               	andq	$0xff, %rax
               	cmpq	$0xd4, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401e2e <.text+0x1b2e>
               	jmp	0x401de5 <.text+0x1ae5>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401d92 <.text+0x1a92>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movslq	%eax, %r15
               	movswq	%r15w, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x401e33 <.text+0x1b33>
               	leaq	0xe36c(%rip), %r14      # 0x410158
               	movl	$0x99, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe7a6(%rip), %r14      # 0x4105b3
               	movl	$0xb0, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401e2e <.text+0x1b2e>
               	jmp	0x401dbf <.text+0x1abf>
               	movq	0x68(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401ebb <.text+0x1bbb>
               	jmp	0x401e72 <.text+0x1b72>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401e33 <.text+0x1b33>
               	jmp	0x401ec0 <.text+0x1bc0>
               	leaq	0xe2df(%rip), %r14      # 0x410158
               	movl	$0x9a, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe734(%rip), %r14      # 0x4105ce
               	movl	$0xb5, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401ebb <.text+0x1bbb>
               	jmp	0x401e5d <.text+0x1b5d>
               	movq	0x68(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401f58 <.text+0x1c58>
               	jmp	0x401f10 <.text+0x1c10>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401ec0 <.text+0x1bc0>
               	movl	$0x1ffff, %eax          # imm = 0x1FFFF
               	movslq	%eax, %rbx
               	movswq	%bx, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x401f5d <.text+0x1c5d>
               	leaq	0xe241(%rip), %r12      # 0x410158
               	movl	$0x9b, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe6b1(%rip), %r12      # 0x4105e9
               	movl	$0xb6, %ebx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401f58 <.text+0x1c58>
               	jmp	0x401eea <.text+0x1bea>
               	movq	0x60(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401fe5 <.text+0x1ce5>
               	jmp	0x401f9c <.text+0x1c9c>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401f5d <.text+0x1c5d>
               	jmp	0x401fea <.text+0x1cea>
               	leaq	0xe1b5(%rip), %r12      # 0x410158
               	movl	$0x9c, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe640(%rip), %r12      # 0x410604
               	movl	$0xba, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401fe5 <.text+0x1ce5>
               	jmp	0x401f87 <.text+0x1c87>
               	movq	0x60(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x402087 <.text+0x1d87>
               	jmp	0x40203f <.text+0x1d3f>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401fea <.text+0x1cea>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	jmp	0x40208c <.text+0x1d8c>
               	leaq	0xe112(%rip), %r15      # 0x410158
               	movl	$0x9d, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe5b9(%rip), %r15      # 0x41061f
               	movl	$0xbb, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x402087 <.text+0x1d87>
               	jmp	0x402014 <.text+0x1d14>
               	movq	0x50(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	%r14, %r15
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40214e <.text+0x1e4e>
               	jmp	0x402106 <.text+0x1e06>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40208c <.text+0x1d8c>
               	movq	0x50(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	0x402153 <.text+0x1e53>
               	leaq	0xe04b(%rip), %rax      # 0x410158
               	movl	$0xa0, %r15d
               	movl	%r15d, (%rax)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe50c(%rip), %r14      # 0x41063a
               	movl	$0xc2, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40214e <.text+0x1e4e>
               	jmp	0x4020c5 <.text+0x1dc5>
               	movq	0x40(%rsp), %r14
               	movslq	%r14d, %r14
               	movq	0x48(%rsp), %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %r14
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4021e8 <.text+0x1ee8>
               	jmp	0x4021a0 <.text+0x1ea0>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x402153 <.text+0x1e53>
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	0x4021ed <.text+0x1eed>
               	leaq	0xdfb1(%rip), %rax      # 0x410158
               	movl	$0xa1, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe48e(%rip), %rbx      # 0x410655
               	movl	$0xc5, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4021e8 <.text+0x1ee8>
               	jmp	0x402180 <.text+0x1e80>
               	movq	0x38(%rsp), %r15
               	movslq	%r15d, %r15
               	movq	%r15, %rbx
               	shlq	$0x1e, %rbx
               	cmpq	$0x40000000, %rbx       # imm = 0x40000000
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x402286 <.text+0x1f86>
               	jmp	0x40223d <.text+0x1f3d>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4021ed <.text+0x1eed>
               	movl	$0x1, %r10d
               	movq	%r10, 0x30(%rsp)
               	jmp	0x40228b <.text+0x1f8b>
               	leaq	0xdf14(%rip), %r15      # 0x410158
               	movl	$0xaa, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe40b(%rip), %r15      # 0x410670
               	movl	$0xcd, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x402286 <.text+0x1f86>
               	jmp	0x40221d <.text+0x1f1d>
               	movq	0x30(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	%r14, %r15
               	shlq	$0x1f, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r14, %r15
               	cmpq	%r11, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40233b <.text+0x203b>
               	jmp	0x4022f3 <.text+0x1ff3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40228b <.text+0x1f8b>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	0x402340 <.text+0x2040>
               	leaq	0xde5e(%rip), %r15      # 0x410158
               	movl	$0xab, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe371(%rip), %r15      # 0x41068b
               	movl	$0xcf, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40233b <.text+0x203b>
               	jmp	0x4022cf <.text+0x1fcf>
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$-0x1, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4023d1 <.text+0x20d1>
               	jmp	0x402389 <.text+0x2089>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x402340 <.text+0x2040>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x20(%rsp)
               	jmp	0x4023d6 <.text+0x20d6>
               	leaq	0xddc8(%rip), %r15      # 0x410158
               	movl	$0xac, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe2f5(%rip), %r15      # 0x4106a6
               	movl	$0xd3, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4023d1 <.text+0x20d1>
               	jmp	0x402369 <.text+0x2069>
               	movq	0x20(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rbx, %r15
               	cmpq	%r11, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40247f <.text+0x217f>
               	jmp	0x402436 <.text+0x2136>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4023d6 <.text+0x20d6>
               	leaq	0xdd37(%rip), %rax      # 0x410158
               	movslq	(%rax), %r14
               	cmpq	$0x0, %r14
               	jne	0x4024bd <.text+0x21bd>
               	jmp	0x402484 <.text+0x2184>
               	leaq	0xdd1b(%rip), %r15      # 0x410158
               	movl	$0xad, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe263(%rip), %r15      # 0x4106c1
               	movl	$0xd5, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40262d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40247f <.text+0x217f>
               	jmp	0x40240a <.text+0x210a>
               	leaq	0xe251(%rip), %r12      # 0x4106dc
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x402633 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	0xdc94(%rip), %r12      # 0x410158
               	movslq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
