
float_is_four_bytes.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x4(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x7, %eax
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x8, %eax
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40600000, %ecx       # imm = 0x40600000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x9, %eax
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40900000, %ecx       # imm = 0x40900000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0xa, %eax
               	movl	$0x3f800000, -0x10(%rbp) # imm = 0x3F800000
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %esi
               	cmpl	$0x3f800000, %esi       # imm = 0x3F800000
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
