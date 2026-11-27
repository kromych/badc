
member_store_constant_readback.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movl	$0x20, %ecx
               	movl	$0x80008080, <rip> # imm = 0x80008080
                                                # <addr>
               	movw	$0x8000, <rip> # imm = 0x8000
                                                # <addr>
               	movabsq	$-0x7fffffff80000000, %rdx # imm = 0x8000000080000000
               	movq	%rdx, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	movw	$0x905, <rip> # imm = 0x905
                                                # <addr>
               	movq	<rip>, %rdx # <addr>
               	movb	$0x7, (%rdx)
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0x7, %edx
               	cmovneq	%rcx, %rax
               	movb	$0x6, <rip> # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	cmpl	$0x6, %ecx
               	cmovneq	%rdx, %rax
               	retq
