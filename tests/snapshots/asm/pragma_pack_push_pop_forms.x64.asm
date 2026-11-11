
pragma_pack_push_pop_forms.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	$0x1d, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x38, %rax
               	jae	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x38, %rax
               	jb	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x2b, %rax
               	sarq	$0x2b, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movb	$0x0, -0x18(%rbp)
               	movb	$0x0, -0x17(%rbp)
               	movb	$0x0, -0x16(%rbp)
               	movb	$0x0, -0x15(%rbp)
               	movb	$0x0, -0x14(%rbp)
               	movb	$0x0, -0x13(%rbp)
               	movb	$0x0, -0x12(%rbp)
               	movb	$0x0, -0x11(%rbp)
               	movb	$0x0, -0x10(%rbp)
               	movb	$0x0, -0xf(%rbp)
               	movb	$0x0, -0xe(%rbp)
               	movb	$0x0, -0xd(%rbp)
               	movb	$0x0, -0xc(%rbp)
               	movb	$0x0, -0xb(%rbp)
               	movb	$0x0, -0xa(%rbp)
               	movb	$0x0, -0x9(%rbp)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	movb	$0x0, -0x4(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movb	$0x0, -0x2(%rbp)
               	movb	$0x0, -0x1(%rbp)
               	movb	$0x38, -0x10(%rbp)
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
