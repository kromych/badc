
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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
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
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %esi
               	movzwq	0x8(%rcx), %rdi
               	movzbq	0xa(%rcx), %r8
               	movzbq	0xb(%rcx), %r9
               	movq	0x10(%rcx), %rbx
               	movl	%edx, %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	cmpq	$0x7865, %rcx           # imm = 0x7865
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %esi
               	movzwq	0x8(%rcx), %rdi
               	movzbq	0xa(%rcx), %r8
               	movzbq	0xb(%rcx), %r9
               	movq	0x10(%rcx), %rbx
               	movl	%edx, %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	cmpq	$0x100f1, %rcx          # imm = 0x100F1
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %esi
               	movzwq	0x8(%rcx), %rdi
               	movzbq	0xa(%rcx), %r8
               	movzbq	0xb(%rcx), %r9
               	movq	0x10(%rcx), %rbx
               	movl	%edx, %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	cmpq	$0xe5, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
               	movl	0x4(%rcx), %edx
               	movzwq	0x8(%rcx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xb(%rcx), %r8
               	movq	0x10(%rcx), %rcx
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %r9d
               	movslq	%edx, %rdx
               	addq	%r9, %rdx
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	addq	%rsi, %rdx
               	movsbq	%dil, %rsi
               	addq	%rsi, %rdx
               	movq	%r8, %rsi
               	andq	$0xff, %rsi
               	addq	%rsi, %rdx
               	sarq	$0x30, %rcx
               	addq	%rdx, %rcx
               	cmpq	$0x11ec, %rcx           # imm = 0x11EC
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
               	movl	0x4(%rcx), %edx
               	movzwq	0x8(%rcx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xb(%rcx), %r8
               	movq	0x10(%rcx), %rcx
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %r9d
               	movslq	%edx, %rdx
               	addq	%r9, %rdx
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	addq	%rsi, %rdx
               	movsbq	%dil, %rsi
               	addq	%rsi, %rdx
               	movq	%r8, %rsi
               	andq	$0xff, %rsi
               	addq	%rsi, %rdx
               	sarq	$0x30, %rcx
               	addq	%rdx, %rcx
               	movl	$0x800000cc, %r11d      # imm = 0x800000CC
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %ecx
               	movl	%ecx, -0x80(%rbp)
               	movl	-0x80(%rbp), %ecx
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
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %esi
               	movzwq	0x8(%rcx), %rdi
               	movzbq	0xa(%rcx), %r8
               	movzbq	0xb(%rcx), %r9
               	movq	0x10(%rcx), %rbx
               	movl	%edx, %ecx
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	jmp	<addr>
               	movslq	%esi, %rdx
               	addq	%rdx, %rcx
               	movq	%rdi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	movsbq	%r8b, %rdx
               	addq	%rdx, %rcx
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	movq	%rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	jmp	<addr>
               	movslq	%esi, %rdx
               	addq	%rdx, %rcx
               	movq	%rdi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	movsbq	%r8b, %rdx
               	addq	%rdx, %rcx
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	movq	%rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	jmp	<addr>
               	movslq	%esi, %rdx
               	addq	%rdx, %rcx
               	movq	%rdi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	movsbq	%r8b, %rdx
               	addq	%rdx, %rcx
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	movq	%rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	jmp	<addr>
