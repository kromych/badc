
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
               	movsbq	<rip>, %rcx # <addr>
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmoveq	%rax, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movsbq	<rip>, %rsi # <addr>
               	movq	%rdx, %rdi
               	orq	$0x4, %rdi
               	cmpl	$0x68, %esi
               	movq	%rdx, %rsi
               	cmovneq	%rdi, %rsi
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rdx
               	leaq	<rip>, %rdi # <addr>
               	movsbq	(%rdi,%rax), %rdi
               	movq	%rsi, %r8
               	orq	$0x8, %r8
               	cmpl	%edi, %edx
               	cmovneq	%r8, %rsi
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
