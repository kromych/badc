
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%rbx)
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	cmpq	$0x4, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rax)
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movl	%edi, -0x18(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rdi
               	cmpq	$0x8, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rbx
               	movslq	(%rbx), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rbx)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %rdi
               	movslq	-0x18(%rbp), %rbx
               	movq	%rbx, %r9
               	shlq	$0x1, %r9
               	addq	%r9, %rdi
               	movl	$0x64, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	movw	%ax, (%rdi)
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
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	movswq	(%rdi), %rdi
               	cmpq	$-0x1, %rdi
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rdi)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	-0x10(%rbp), %rbx
               	movq	%rbx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rax
               	movslq	-0x18(%rbp), %rdi
               	movq	%rdi, %r9
               	shlq	$0x1, %r9
               	addq	%r9, %rax
               	movswq	(%rax), %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %rbx
               	movslq	%ebx, %rbx
               	addq	%rdi, %rbx
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
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x63, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
