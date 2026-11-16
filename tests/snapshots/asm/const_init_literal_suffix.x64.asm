
const_init_literal_suffix.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x218711a00, %r11      # imm = 0x218711A00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x200000000, %r11      # imm = 0x200000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
