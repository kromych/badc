
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, %eax
               	xorq	%rsi, %rsi
               	movq	%rax, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rdx
               	wrpkru
               	movq	%rsi, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rcx
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movl	%ds:<rip>, %eax
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	movl	-0x8(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
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
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movl	%ds:<rip>, %eax
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
