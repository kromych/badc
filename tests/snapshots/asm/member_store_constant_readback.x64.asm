
member_store_constant_readback.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x20, 0x1(%rcx)
               	movb	$-0x80, (%rcx)
               	movb	$-0x80, 0x1(%rcx)
               	movw	$0x8000, 0x2(%rcx)      # imm = 0x8000
               	movw	$0x8000, 0x4(%rcx)      # imm = 0x8000
               	movl	$0x80000000, 0x8(%rcx)  # imm = 0x80000000
               	movl	$0x80000000, 0xc(%rcx)  # imm = 0x80000000
               	movq	$-0x1, 0x10(%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x1, (%rcx)
               	movb	$0x2, 0x1(%rcx)
               	movb	$0x3, (%rcx)
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, (%rdx)
               	movb	$0x4, (%rcx)
               	movb	$0x9, (%rcx)
               	movb	$0x4, (%rcx)
               	movb	$0x9, 0x1(%rcx)
               	movb	$0x5, (%rcx)
               	movq	(%rdx), %rdx
               	movb	$0x7, (%rdx)
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx), %esi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movzbq	(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x6, (%rcx)
               	movzbq	(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	orq	$0x40, %rax
               	retq
