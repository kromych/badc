
paren_string_char_array_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx # <addr>
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	leaq	0x8(%rcx), %rdi
               	cmpb	$0x0, (%rdx,%rax)
               	je	<addr>
               	movzbq	(%rdi,%rax), %r8
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpb	$0x0, (%rdx,%rax)
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
