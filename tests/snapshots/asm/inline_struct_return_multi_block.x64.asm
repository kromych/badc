
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
               	movq	$-0x1, %rax
               	movslq	%eax, %rax
               	retq
               	andq	$0x3, %rax
               	movslq	(%rdi,%rax,4), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rcx
               	movl	$0x20, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rdx
               	movl	-0x8(%rbp), %eax
               	leaq	<rip>, %rdi
               	shrq	$0x5, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rsi)
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rsi)
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movl	(%rcx), %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x1, %r8d
               	movl	%r8d, (%rcx)
               	leaq	(%rdi,%rsi), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %esi
               	movzwq	0x8(%rax), %rdi
               	movzbq	0xa(%rax), %r8
               	movzbq	0xb(%rax), %r9
               	movq	0x10(%rax), %rbx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	$-0x1, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	$-0x1, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	movsbq	%r8b, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	andq	$0x3, %rax
               	movslq	(%rdx,%rax,4), %rax
               	jmp	<addr>
