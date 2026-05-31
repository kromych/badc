
comma_operator_in_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003ce <.text+0x14e>
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
               	callq	0x4006d7 <dlsym>
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
               	movslq	%edi, %rax
               	leaq	0xfd88(%rip), %r9       # 0x410148
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x4003f7 <.text+0x177>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0xa, %r9
               	movl	%r9d, (%r11)
               	jmp	0x40040d <.text+0x18d>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x4003b6 <.text+0x136>
               	cmpq	$0x0, %rbx
               	jne	0x4003f7 <.text+0x177>
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	je	0x40045a <.text+0x1da>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x64, %rax
               	movl	%eax, (%r12)
               	jmp	0x40045a <.text+0x1da>
               	movl	$0x7, %ebx
               	movq	%rbx, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movl	$0x2, %eax
               	jmp	0x4004bf <.text+0x23f>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x4004de <.text+0x25e>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x400471 <.text+0x1f1>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r12
               	addq	$0x3e8, %r12            # imm = 0x3E8
               	movl	%r12d, (%rax)
               	jmp	0x400471 <.text+0x1f1>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rbx
               	addq	$0x1869f, %rbx          # imm = 0x1869F
               	movl	%ebx, (%r12)
               	jmp	0x400471 <.text+0x1f1>
               	cmpq	$0x1, %rax
               	je	0x40047c <.text+0x1fc>
               	cmpq	$0x2, %rax
               	je	0x400491 <.text+0x211>
               	jmp	0x4004a7 <.text+0x227>
               	xorq	%r14, %r14
               	movq	%r14, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	0x40052b <.text+0x2ab>
               	jmp	0x400515 <.text+0x295>
               	leaq	-0x8(%rbp), %r14
               	movslq	(%r14), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r14)
               	jmp	0x4004de <.text+0x25e>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rax)
               	jmp	0x4004ff <.text+0x27f>
               	leaq	0xfc16(%rip), %r12      # 0x410148
               	movslq	(%r12), %r14
               	cmpq	$0x7, %r14
               	je	0x400566 <.text+0x2e6>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %r14
               	subq	$0x456, %r14            # imm = 0x456
               	movslq	%r14d, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
