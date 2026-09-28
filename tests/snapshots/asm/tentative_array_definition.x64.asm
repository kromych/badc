
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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1, %ecx
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rsi
               	cmpl	$0x68, %esi
               	je	<addr>
               	orq	$0x4, %rcx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	cmpb	$0x0, (%rsi,%rax)
               	je	<addr>
               	movsbq	(%rdx,%rax), %r8
               	movsbq	(%rdi,%rax), %r9
               	cmpl	%r9d, %r8d
               	je	<addr>
               	orq	$0x8, %rcx
               	incq	%rax
               	cmpb	$0x0, (%rsi,%rax)
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rsi
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
               	movq	%rax, %rcx
               	jmp	<addr>
