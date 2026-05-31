
designated_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400bb7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfd7c(%rip), %r9       # 0x410148
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x40042a <.text+0x1aa>
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r9
               	cmpq	$0x2, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	jmp	0x40042a <.text+0x1aa>
               	movq	-0x90(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x40044c <.text+0x1cc>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	leaq	0xfcf9(%rip), %rax      # 0x410150
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	popq	%r11
               	movq	%r9, %r11
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4004b7 <.text+0x237>
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	0x4004b7 <.text+0x237>
               	movq	-0x98(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4004dd <.text+0x25d>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	0xfc70(%rip), %r11      # 0x410158
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x400546 <.text+0x2c6>
               	leaq	-0x18(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x63, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	jmp	0x400546 <.text+0x2c6>
               	movq	-0xa0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400568 <.text+0x2e8>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r11
               	leaq	0xfbed(%rip), %rax      # 0x410160
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%r11)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%r11)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%r11)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%r11)
               	popq	%rcx
               	movq	%r11, %r9
               	leaq	-0x28(%rbp), %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4005f5 <.text+0x375>
               	leaq	-0x28(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	0x4005f5 <.text+0x375>
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400639 <.text+0x3b9>
               	leaq	-0x28(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	jmp	0x400639 <.text+0x3b9>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40065f <.text+0x3df>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	0xfb02(%rip), %r9       # 0x41016c
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movq	%rax, %r11
               	leaq	-0x30(%rbp), %r11
               	movslq	(%r11), %r9
               	cmpq	$0x7, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xb8(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x4006ca <.text+0x44a>
               	leaq	-0x30(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r9
               	cmpq	$0xe, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xb8(%rbp)
               	jmp	0x4006ca <.text+0x44a>
               	movq	-0xb8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x4006ec <.text+0x46c>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r9
               	leaq	0xfa7d(%rip), %rax      # 0x410174
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%r9)
               	movzbq	0x10(%rax), %r11
               	movb	%r11b, 0x10(%r9)
               	movzbq	0x11(%rax), %r11
               	movb	%r11b, 0x11(%r9)
               	movzbq	0x12(%rax), %r11
               	movb	%r11b, 0x12(%r9)
               	movzbq	0x13(%rax), %r11
               	movb	%r11b, 0x13(%r9)
               	popq	%r11
               	movq	%r9, %r11
               	leaq	-0x48(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0xa, %rax
               	je	0x400756 <.text+0x4d6>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x40077f <.text+0x4ff>
               	movl	$0xc, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x4007ac <.text+0x52c>
               	movl	$0xd, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4007d5 <.text+0x555>
               	movl	$0xe, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x32, %rax
               	je	0x400802 <.text+0x582>
               	movl	$0xf, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	leaq	0xf97b(%rip), %r11      # 0x410188
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r11), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%r11), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%r11), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%r11), %rcx
               	movq	%rcx, 0x20(%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x70(%rbp), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x0, %r11
               	je	0x40085a <.text+0x5da>
               	movl	$0x15, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0xc8, %rax
               	je	0x400887 <.text+0x607>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4008b0 <.text+0x630>
               	movl	$0x17, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x1c, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2bc, %rax            # imm = 0x2BC
               	je	0x4008dd <.text+0x65d>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x400906 <.text+0x686>
               	movl	$0x19, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x24, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	0x400933 <.text+0x6b3>
               	movl	$0x1a, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	0xf86f(%rip), %r11      # 0x4101b0
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r11), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%r11), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x88(%rbp), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x1, %r11
               	je	0x400981 <.text+0x701>
               	movl	$0x1f, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2, %rax
               	je	0x4009b1 <.text+0x731>
               	movl	$0x20, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4009dd <.text+0x75d>
               	movl	$0x21, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x400a0d <.text+0x78d>
               	movl	$0x22, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x32, %r11
               	je	0x400a39 <.text+0x7b9>
               	movl	$0x23, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	addq	$0x14, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x3c, %rax
               	je	0x400a69 <.text+0x7e9>
               	movl	$0x24, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
