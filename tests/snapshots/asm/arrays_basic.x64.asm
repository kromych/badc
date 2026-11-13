
arrays_basic.x64:	file format elf64-x86-64

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
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movq	%rax, -0x18(%rbp)
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	-0x18(%rbp,%rax,4), %esi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$0xa00000000, %rcx      # imm = 0xA00000000
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x1e00000014, %rcx     # imm = 0x1E00000014
               	movq	%rcx, <rip> # <addr>
               	movl	$0x28, <rip> # <addr>
               	movw	$0x6968, <rip> # imm = 0x6968
                                                # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	-0x10(%rbp), %eax
               	movl	-0xc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
