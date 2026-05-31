
signed_cast_extends.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
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
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
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
               	callq	0x4008f7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xff, %r11d
               	movq	%r11, %r9
               	andq	$0xff, %r9
               	movsbq	%r9b, %r9
               	movslq	%r9d, %r11
               	cmpq	$-0x1, %r11
               	je	0x40045c <.text+0x19c>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %r9d
               	movq	%r9, %r11
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r9
               	cmpq	$-0x80, %r9
               	je	0x400499 <.text+0x1d9>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %r11d
               	movq	%r11, %r9
               	andq	$0xff, %r9
               	movsbq	%r9b, %r9
               	movslq	%r9d, %r11
               	cmpq	$0x7f, %r11
               	je	0x4004d6 <.text+0x216>
               	movl	$0x3, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %r9d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r9
               	cmpq	$-0x1, %r9
               	je	0x400512 <.text+0x252>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movsbq	%r9b, %r9
               	movslq	%r9d, %r11
               	cmpq	$0x78, %r11
               	je	0x40054e <.text+0x28e>
               	movl	$0x5, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %r9d       # imm = 0x1234ABFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r9
               	cmpq	$-0x1, %r9
               	je	0x40058a <.text+0x2ca>
               	movl	$0x6, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %r11d          # imm = 0xFFFF
               	movq	%r11, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movswq	%r9w, %r9
               	movslq	%r9d, %r11
               	cmpq	$-0x1, %r11
               	je	0x4005c7 <.text+0x307>
               	movl	$0x7, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %r9d           # imm = 0x8000
               	movq	%r9, %r11
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r9
               	cmpq	$-0x8000, %r9           # imm = 0x8000
               	je	0x400604 <.text+0x344>
               	movl	$0x8, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movswq	%r9w, %r9
               	movslq	%r9d, %r11
               	cmpq	$0x5678, %r11           # imm = 0x5678
               	je	0x400640 <.text+0x380>
               	movl	$0x9, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %r9d       # imm = 0x1234FFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	movswq	%r11w, %r11
               	movslq	%r11d, %r9
               	cmpq	$-0x1, %r9
               	je	0x40067c <.text+0x3bc>
               	movl	$0xa, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2a, %r11
               	movsbq	%r11b, %r9
               	movslq	%r9d, %r11
               	cmpq	$-0x2a, %r11
               	je	0x4006b3 <.text+0x3f3>
               	movl	$0xb, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r9
               	movl	$0xff, %r11d
               	movb	%r11b, (%r9)
               	leaq	-0xb8(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movl	$0x42, %r8d
               	movb	%r8b, (%r11)
               	leaq	-0xb8(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x2, %r8
               	movl	$0x10, %r9d
               	movb	%r9b, (%r8)
               	leaq	-0xb8(%rbp), %r11
               	movzbq	(%r11), %r9
               	movsbq	%r9b, %r9
               	movslq	%r9d, %r11
               	cmpq	$-0x1, %r11
               	je	0x40072f <.text+0x46f>
               	movl	$0xc, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r9
               	movzbq	(%r9), %r11
               	movsbq	%r11b, %r11
               	movq	%r11, %r9
               	shlq	$0x8, %r9
               	movslq	%r9d, %r9
               	leaq	-0xb8(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r11
               	movq	%r9, %r8
               	orq	%r11, %r8
               	movslq	%r8d, %r11
               	cmpq	$-0xbe, %r11
               	je	0x40078c <.text+0x4cc>
               	movl	$0xd, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf9bd(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x4008fd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	xorq	%r11, %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
