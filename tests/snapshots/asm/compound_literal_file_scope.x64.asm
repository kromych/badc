
compound_literal_file_scope.x64:	file format elf64-x86-64

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
               	callq	0x400847 <dlsym>
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
               	subq	$0x40, %rsp
               	leaq	0xfd80(%rip), %r11      # 0x410148
               	movq	(%r11), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x1, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x10(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x40041a <.text+0x19a>
               	leaq	0xfd53(%rip), %r9       # 0x410148
               	movq	(%r9), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x4, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x40041a <.text+0x19a>
               	movq	-0x10(%rbp), %r9
               	movq	%r9, -0x8(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x40045b <.text+0x1db>
               	leaq	0xfd12(%rip), %r11      # 0x410148
               	movq	(%r11), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x4, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	jmp	0x40045b <.text+0x1db>
               	movq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x40047a <.text+0x1fa>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcdf(%rip), %r11      # 0x410160
               	movq	(%r11), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x2, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x20(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x4004d3 <.text+0x253>
               	leaq	0xfcb2(%rip), %rax      # 0x410160
               	movq	(%rax), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	0x4004d3 <.text+0x253>
               	movq	-0x20(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400514 <.text+0x294>
               	leaq	0xfc71(%rip), %r11      # 0x410160
               	movq	(%r11), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x8, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	0x400514 <.text+0x294>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400533 <.text+0x2b3>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc3e(%rip), %r11      # 0x410178
               	movq	(%r11), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x40055b <.text+0x2db>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc16(%rip), %r11      # 0x410178
               	movq	(%r11), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	movzbq	(%r11), %rax
               	xorq	$0x72, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x28(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4005ea <.text+0x36a>
               	leaq	0xfbce(%rip), %r11      # 0x410178
               	movq	(%r11), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x28(%rbp)
               	jmp	0x4005ea <.text+0x36a>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40060d <.text+0x38d>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb64(%rip), %rax      # 0x410178
               	movq	(%rax), %r11
               	addq	$0x10, %r11
               	movq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x400640 <.text+0x3c0>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb59(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400699 <.text+0x419>
               	leaq	0xfb2c(%rip), %r11      # 0x4101a0
               	movq	(%r11), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x38(%rbp)
               	jmp	0x400699 <.text+0x419>
               	movq	-0x38(%rbp), %r11
               	movq	%r11, -0x30(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x4006da <.text+0x45a>
               	leaq	0xfaeb(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x4006da <.text+0x45a>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4006fd <.text+0x47d>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
