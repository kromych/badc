
standard_streams_are_objects.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0x2a, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x21, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rsp), %r11
               	movq	%r11, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rbx, %rdx
               	movl	$0x10, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0xa, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rdx
               	cmpq	0x18(%rsp), %rdx
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
