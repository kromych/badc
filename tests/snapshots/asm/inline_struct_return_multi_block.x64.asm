
inline_struct_return_multi_block.x64:	file format elf64-x86-64

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

<reg_slot>:
               	movl	%esi, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
               	retq
               	andq	$0x3, %rax
               	movslq	(%rdi,%rax,4), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	<rip>, %rcx
               	movl	$0x14, %eax
               	movl	$0x7865, %eax           # imm = 0x7865
               	movl	$0x28, %eax
               	movl	$0x100f1, %eax          # imm = 0x100F1
               	movl	$0x14, %eax
               	movl	$0xe5, %eax
               	movl	$0x20, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	<rip>, %rsi
               	shrq	$0x5, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x1, %edi
               	movl	%edi, (%rdx)
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x1, %edi
               	movl	%edi, (%rdx)
               	leaq	<rip>, %rdx
               	imulq	$0x18, %rax, %rdi
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x1, %edi
               	movl	%edi, (%rdx)
               	imulq	$0x18, %rax, %rax
               	addq	%rsi, %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %esi
               	movzwq	0x8(%rax), %rdi
               	movzbq	0xa(%rax), %r8
               	movzbq	0xb(%rax), %r9
               	movq	0x10(%rax), %r13
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	movsbq	%r8b, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	movq	%r13, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movq	%rdx, %rax
               	andq	$0x3, %rax
               	movslq	(%rcx,%rax,4), %rax
               	jmp	<addr>
