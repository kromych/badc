
vector_lanes_of_8_byte_vectors.x64:	file format elf64-x86-64

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

<read_b>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	paddb	%xmm1, %xmm0
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, -0x8(%rbp)
               	andq	$0x7, %rdi
               	movsbq	(%rax,%rdi), %rax
               	movsbq	-0x1(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<write_h>:
               	movq	$-0x7, %rax
               	psubw	%xmm1, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	retq

<read_s>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	vmovq	%xmm0, %rax
               	movabsq	$0x200000001, %r11      # imm = 0x200000001
               	xorq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	-0x4(%rbp), %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %r9
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	$0x3, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	cmpl	$0xab, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %r9
               	leaq	-0x8(%rbp), %rax
               	xorl	%edi, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	cmpl	$0x8a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %r9
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	$-0x7, %rdi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movswq	-0x10(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movswq	-0xe(%rbp), %rax
               	cmpl	$0xc6, %eax
               	jne	<addr>
               	movswq	-0xc(%rbp), %rax
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	movswq	-0xa(%rbp), %rax
               	cmpl	$0xfffffe6c, %eax       # imm = 0xFFFFFE6C
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %r9
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	cmpl	$0x80000002, %eax       # imm = 0x80000002
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzwq	-0xe(%rbp), %rax
               	movzwq	-0xa(%rbp), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffe6c, %ecx       # imm = 0xFFFFFE6C
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xc6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
