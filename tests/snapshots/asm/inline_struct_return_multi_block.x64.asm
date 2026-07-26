
inline_struct_return_multi_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<reg_slot>:
               	movl	%esi, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
               	retq
               	movl	%esi, %eax
               	andq	$0x3, %rax
               	movslq	(%rdi,%rax,4), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	<rip>, %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movslq	%ecx, %rdx
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	cmpq	$0x7865, %rcx           # imm = 0x7865
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x18, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movslq	%ecx, %rdx
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	cmpq	$0x100f1, %rcx          # imm = 0x100F1
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x48, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movslq	%ecx, %rdx
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	cmpq	$0xe5, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx), %edx
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movzwq	0x8(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movsbq	0xa(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movzbq	0xb(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	sarq	$0x30, %rcx
               	addq	%rdx, %rcx
               	cmpq	$0x11ec, %rcx           # imm = 0x11EC
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x30, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx), %edx
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movzwq	0x8(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movsbq	0xa(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movzbq	0xb(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x48(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	sarq	$0x30, %rcx
               	addq	%rdx, %rcx
               	movl	$0x800000cc, %r11d      # imm = 0x800000CC
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %ecx
               	movl	%ecx, -0xb0(%rbp)
               	movl	-0xb0(%rbp), %ecx
               	leaq	-0x78(%rbp), %rdx
               	movl	%ecx, %ecx
               	leaq	<rip>, %rsi
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	shrq	$0x5, %rcx
               	movl	%ecx, %edi
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rdi)
               	movl	%ecx, %edi
               	cmpq	$0x4, %rdi
               	jb	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rdi)
               	leaq	<rip>, %rdi
               	movl	%ecx, %r8d
               	imulq	$0x18, %r8, %r8
               	addq	%r8, %rdi
               	movl	(%rdi), %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rdi)
               	movl	%ecx, %ecx
               	imulq	$0x18, %rcx, %rcx
               	addq	%rsi, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movzwq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movsbq	0xa(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movzbq	0xb(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movq	0x10(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movzwq	0x8(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movsbq	0xa(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movzbq	0xb(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movzwq	0x8(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movsbq	0xa(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movzbq	0xb(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movzwq	0x8(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movsbq	0xa(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movzbq	0xb(%rcx), %rcx
               	addq	%rcx, %rdx
               	leaq	-0x90(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
