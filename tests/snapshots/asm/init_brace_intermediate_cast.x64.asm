
init_brace_intermediate_cast.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x6db6db6d, %rax      # imm = 0x92492493
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x6db6db6d, %rax      # imm = 0x92492493
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x38, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x6db6db6d, %rax      # imm = 0x92492493
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x38, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x6db6db6d, %rax      # imm = 0x92492493
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	xorl	%eax, %eax
               	retq
