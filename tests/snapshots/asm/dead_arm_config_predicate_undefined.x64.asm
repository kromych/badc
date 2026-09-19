
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
               	xorl	%edx, %edx
               	leaq	-0x8(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movl	$0x1, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	addq	%rsi, %rax
               	leaq	0xa(%rax), %rdx
               	movl	$0x2, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0x3, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0x4, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0x5, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0x6, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0x7, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0x8, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0x9, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0xb, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0xc, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	movl	$0xe, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	leaq	(%rdx,%rax), %rcx
               	movl	$0xf, %eax
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpl	$0xb0, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
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
               	movq	%rdx, %rax
               	jmp	<addr>
