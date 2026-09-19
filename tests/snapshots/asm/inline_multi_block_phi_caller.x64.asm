
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax
               	movl	(%rax), %r8d
               	xorq	%rdx, %rdx
               	movl	%edx, %eax
               	cmpl	%r8d, %eax
               	jae	<addr>
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rax, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movl	%edi, %edi
               	cmpl	$0x1, %edi
               	jb	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movl	%ecx, (%rsi,%rdi,4)
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movl	(%rsi,%rdi,4), %ebx
               	movq	%rbx, %r9
               	xorq	%rcx, %r9
               	movl	%r9d, (%rsi,%rdi,4)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movl	(%rsi,%rdi,4), %ebx
               	leaq	(%rbx,%rcx), %r9
               	movl	%r9d, (%rsi,%rdi,4)
               	jmp	<addr>
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
               	movq	(%rsp), %rbx
               	leave
               	retq
