
tentative_array_definition.x64:	file format elf64-x86-64

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

<take_never>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rax
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
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpb	$0x0, (%rdx,%rax)
               	je	<addr>
               	movsbq	(%rdi,%rax), %r8
               	movq	%rsi, %r9
               	orq	$0x8, %r9
               	movsbq	(%rcx,%rax), %r10
               	cmpl	%r8d, %r10d
               	cmovneq	%r9, %rsi
               	incq	%rax
               	nop
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
