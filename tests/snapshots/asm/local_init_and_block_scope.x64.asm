
local_init_and_block_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	addq	%rsi, %rdi
               	movslq	%edi, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorq	%rax, %rax
               	movl	$0x41, %edi
               	leaq	<rip>, %r8
               	movl	$0x1, %ecx
               	movl	%ecx, -0x20(%rbp)
               	movl	$0x3, %ecx
               	movl	$0x2, %edx
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	$0x41, %rdi
               	movl	%edi, %edi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%r8), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x69, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	addq	%rcx, %rsi
               	movslq	%esi, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	$0x14, %ecx
               	movl	$0x1e, %edx
               	addq	%rcx, %rdi
               	movslq	%edi, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %ecx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x60(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%ecx, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
