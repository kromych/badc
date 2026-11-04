
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

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

<dispatch>:
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	testb	$0x8, %dl
               	je	<addr>
               	addq	$0xb, %rax
               	leaq	0xa(%rax), %rcx
               	movq	$0x2, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0x3, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rax, %rcx
               	movq	$0x4, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0x5, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rax, %rcx
               	movq	$0x6, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0x7, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rax, %rcx
               	movq	$0x8, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0x9, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rax, %rcx
               	movq	$0xa, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0xb, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rax, %rcx
               	movq	$0xc, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0xd, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rax, %rcx
               	movq	$0xe, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa, %rax
               	addq	%rax, %rcx
               	movq	$0xf, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb, %rax
               	addq	%rcx, %rax
               	cmpl	$0xb0, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
