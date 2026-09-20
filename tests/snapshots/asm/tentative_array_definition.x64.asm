
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
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	<rip>, %rsi
               	movsbq	(%rsi), %rdx
               	cmpl	$0x68, %edx
               	je	<addr>
               	orq	$0x4, %rax
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movslq	%ecx, %rdx
               	cmpb	$0x0, (%rdi,%rdx)
               	je	<addr>
               	movsbq	(%rsi,%rdx), %r9
               	movsbq	(%r8,%rdx), %rdx
               	cmpl	%edx, %r9d
               	je	<addr>
               	orq	$0x8, %rax
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpb	$0x0, (%rdi,%rdx)
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
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
