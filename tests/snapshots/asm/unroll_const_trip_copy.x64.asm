
unroll_const_trip_copy.x64:	file format elf64-x86-64

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
               	movq	$0x1, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x7, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0xd, <rip> # <addr>
               	movq	$0x10, <rip> # <addr>
               	movq	$0x13, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	$0x16, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rcx)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%rcx)
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	shlq	%rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1c8, %rax            # imm = 0x1C8
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq
