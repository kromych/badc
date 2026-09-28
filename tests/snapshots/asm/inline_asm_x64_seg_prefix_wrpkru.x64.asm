
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
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	wrpkru
               	retq

<main>:
               	movl	%ds:<rip>, %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	clflush	%ds:<rip>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	nop
               	nop
               	nop
               	leaq	<rip>, %rax
               	movl	$0x12345678, (%rax)     # imm = 0x12345678
               	movl	%ds:<rip>, %eax
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
