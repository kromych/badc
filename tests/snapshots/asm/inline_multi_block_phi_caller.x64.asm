
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
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %edx
               	leaq	<rip>, %rax
               	movl	(%rax), %r9d
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rax, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movl	%edx, %esi
               	movl	%edi, %edi
               	cmpq	$0x1, %rdi
               	jb	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	%eax, %r8d
               	movl	%esi, %ebx
               	leaq	<rip>, %rdi
               	movl	%r8d, %r8d
               	andq	$0x3, %r8
               	movl	%ebx, %ebx
               	movl	%ebx, (%rdi,%r8,4)
               	imulq	$0x41c64e6d, %rsi, %rdx # imm = 0x41C64E6D
               	movl	%edx, %edx
               	addq	$0x3039, %rdx           # imm = 0x3039
               	movl	%edx, %edx
               	jmp	<addr>
               	movl	%eax, %r8d
               	movl	%esi, %ebx
               	leaq	<rip>, %rdi
               	movl	%r8d, %r8d
               	andq	$0x3, %r8
               	movl	(%rdi,%r8,4), %r12d
               	movl	%ebx, %ebx
               	xorq	%r12, %rbx
               	movl	%ebx, (%rdi,%r8,4)
               	jmp	<addr>
               	movl	%eax, %r8d
               	movl	%esi, %ebx
               	leaq	<rip>, %rdi
               	movl	%r8d, %r8d
               	andq	$0x3, %r8
               	movl	(%rdi,%r8,4), %r12d
               	movl	%ebx, %ebx
               	addq	%r12, %rbx
               	movl	%ebx, (%rdi,%r8,4)
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	movl	%r9d, %esi
               	cmpq	%rsi, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0xc(%rax), %eax
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
