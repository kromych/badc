
paren_string_char_array_init.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rsi # <addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5f, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x73, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	addq	$0x8, %rsi
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movzbq	(%rsi,%rax), %rdi
               	movsbq	(%rdx,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6f, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x77, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x70, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	retq
