
inline_multi_block_phi_caller.x64:	file format elf64-x86-64

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
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax
               	movl	(%rax), %r8d
               	xorl	%edx, %edx
               	movl	%edx, %eax
               	cmpl	%r8d, %eax
               	jae	<addr>
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rax, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	cmpl	$0x1, %esi
               	jb	<addr>
               	cmpl	$0x1, %esi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movl	%ecx, (%rsi,%rdi,4)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movl	(%rsi,%rdi,4), %r9d
               	xorq	%rcx, %r9
               	movl	%r9d, (%rsi,%rdi,4)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movl	(%rsi,%rdi,4), %r9d
               	addq	%rcx, %r9
               	movl	%r9d, (%rsi,%rdi,4)
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	leaq	0x1(%rax), %rdx
               	movl	%edx, %eax
               	cmpl	%r8d, %eax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0xc(%rax), %eax
               	xorq	%rcx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	retq
