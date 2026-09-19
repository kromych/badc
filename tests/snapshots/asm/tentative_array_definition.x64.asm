
tentative_array_definition.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<take_never>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x68, %edx
               	je	<addr>
               	orq	$0x4, %rax
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movslq	%ecx, %rdx
               	movsbq	(%rsi,%rdx), %r9
               	testq	%r9, %r9
               	je	<addr>
               	movsbq	(%r8,%rdx), %r9
               	movsbq	(%rdi,%rdx), %rdx
               	cmpl	%edx, %r9d
               	je	<addr>
               	orq	$0x8, %rax
               	incq	%rcx
               	movslq	%ecx, %rdx
               	movsbq	(%rsi,%rdx), %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movslq	%eax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
