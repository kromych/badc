
static_init_struct_fp_call.x64:	file format elf64-x86-64

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
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movq	(%rcx), %rsi
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
               	addq	%rax, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	addq	%rsi, %rdi
               	movslq	%edi, %rax
               	retq
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	subq	%rsi, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0x8, %rbx
               	movq	(%rbx), %rax
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
