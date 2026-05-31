
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
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
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x40, %r9d
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%rbx)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r12
               	cmpq	$0x4, %r12
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rax)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movl	%r12d, -0x18(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r12
               	cmpq	$0x8, %r12
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rbx
               	movslq	(%rbx), %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rbx)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r12
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %r12
               	movslq	-0x18(%rbp), %rbx
               	movq	%rbx, %rdi
               	shlq	$0x1, %rdi
               	addq	%rdi, %r12
               	movl	$0x64, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	movw	%ax, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x1, %rbx
               	movw	%bx, (%rax)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r12
               	movswq	(%r12), %r12
               	cmpq	$-0x1, %r12
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	-0x10(%rbp), %rbx
               	movq	%rbx, %r12
               	shlq	$0x4, %r12
               	addq	%r12, %rax
               	movslq	-0x18(%rbp), %r12
               	movq	%r12, %rdi
               	shlq	$0x1, %rdi
               	addq	%rdi, %rax
               	movswq	(%rax), %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %rbx
               	movslq	%ebx, %rbx
               	addq	%r12, %rbx
               	movslq	%ebx, %rbx
               	movswq	%bx, %rbx
               	cmpq	%rbx, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	addq	$0xa, %rbx
               	movslq	%ebx, %rbx
               	movslq	-0x18(%rbp), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x63, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %r14
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
