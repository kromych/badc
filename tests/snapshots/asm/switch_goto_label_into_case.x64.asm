
switch_goto_label_into_case.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	jmp	<addr>
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %r8d
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %r11
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x8(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x1, %r11
               	je	<addr>
               	cmpq	$0x2, %r11
               	je	<addr>
               	cmpq	$0x3, %r11
               	je	<addr>
               	cmpq	$0x4, %r11
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x8, %r11
               	setle	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
