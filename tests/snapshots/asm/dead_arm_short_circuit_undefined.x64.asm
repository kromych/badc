
dead_arm_short_circuit_undefined.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	testb	$0x1, %cl
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	testb	$0x1, %sil
               	jne	<addr>
               	movq	$0x0, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	%rcx, (%rax)
               	movq	$0x3, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movq	(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movq	$0x0, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	$0x5, 0x8(%rax)
               	testb	$0x1, %cl
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	testb	$0x1, %sil
               	jne	<addr>
               	movq	$0x0, (%rax)
               	movq	$0x6, 0x8(%rax)
               	movq	%rcx, (%rax)
               	movq	$0x7, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movq	(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	cmpl	$0x1, %ecx
               	jmp	<addr>
               	movq	0x8(%rax), %rsi
               	andq	$0xff, %rsi
               	cmpl	$0x1, %esi
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	cmpl	$0x1, %ecx
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	cmpl	$0x1, %ecx
               	jmp	<addr>
               	movq	0x8(%rax), %rsi
               	andq	$0xff, %rsi
               	cmpl	$0x1, %esi
               	jmp	<addr>
