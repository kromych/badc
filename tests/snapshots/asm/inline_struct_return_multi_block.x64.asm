
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
               	movq	%rbx, (%rsp)
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
               	movl	%eax, %eax
               	leaq	<rip>, %rdi
               	movl	%eax, %eax
               	movl	%eax, %eax
               	shrq	$0x5, %rax
               	movl	%eax, %edx
               	cmpq	$0x9, %rdx
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rsi)
               	cmpq	$0x4, %rdx
               	jb	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rsi)
               	leaq	<rip>, %rsi
               	imulq	$0x18, %rdx, %r8
               	addq	%r8, %rsi
               	movl	(%rsi), %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rsi)
               	imulq	$0x18, %rdx, %rax
               	addq	%rdi, %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %esi
               	movzwq	0x8(%rax), %rdi
               	movzbq	0xa(%rax), %r8
               	movzbq	0xb(%rax), %r9
               	movq	0x10(%rax), %rbx
               	movl	%edx, %eax
               	movl	%esi, %esi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	andq	$0xff, %r8
               	andq	$0xff, %r9
               	movl	%eax, %edx
               	movl	%edx, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	movsbq	%r8b, %rcx
               	addq	%rcx, %rax
               	movq	%r9, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	andq	$0x3, %rax
               	movslq	(%rcx,%rax,4), %rax
               	jmp	<addr>
