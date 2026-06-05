
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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
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
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	-0x10(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movslq	-0x18(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x1, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	movw	%cx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movswq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	-0x10(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movslq	-0x18(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x1, %rsi
               	addq	%rsi, %rax
               	movswq	(%rax), %rax
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movslq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x63, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rdi
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
