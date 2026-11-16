
constant_conditional_result_type.x64:	file format elf64-x86-64

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
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
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
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
