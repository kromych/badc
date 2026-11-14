
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
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	movl	$0x1, %esi
               	cmpb	$0x0, <rip> # <addr>
               	cmoveq	%rax, %rsi
               	leaq	<rip>, %rcx # <addr>
               	movq	%rsi, %rdx
               	orq	$0x4, %rdx
               	movsbq	<rip>, %rdi # <addr>
               	cmpl	$0x68, %edi
               	cmovneq	%rdx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movsbq	(%rdx,%rax), %rdx
               	movq	%rsi, %rdi
               	orq	$0x8, %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	incq	%rax
               	leaq	<rip>, %rdx # <addr>
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
