
inline_asm_x64_seg_prefix_wrpkru.x64:	file format elf64-x86-64

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

<write_pkru>:
               	movl	%edi, %eax
               	xorq	%rcx, %rcx
               	xorq	%rdx, %rdx
               	wrpkru
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rcx
               	movl	%ds:<rip>, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	clflush	%ds:<rip>
               	movl	(%rcx), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	nop
               	nop
               	nop
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	%eax, (%rcx)
               	movl	%ds:<rip>, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
