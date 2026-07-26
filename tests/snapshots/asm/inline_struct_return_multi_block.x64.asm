
inline_struct_return_multi_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<reg_of>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movl	0x20(%rbp), %eax
               	movl	%eax, %eax
               	shrq	$0x5, %rax
               	movl	%eax, %esi
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %edi
               	movl	%edi, (%rsi)
               	movl	%eax, %esi
               	cmpq	$0x4, %rsi
               	jb	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %edi
               	movl	%edi, (%rsi)
               	movl	%eax, %esi
               	imulq	$0x18, %rsi, %rsi
               	addq	%rdx, %rsi
               	movl	(%rsi), %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %edi
               	movl	%edi, (%rsi)
               	movl	%eax, %eax
               	imulq	$0x18, %rax, %rax
               	addq	%rdx, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

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

<direct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x60(%rbp), %rax
               	movl	%edi, %esi
               	movq	%rax, %rdi
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x48(%rbp), %rax
               	movzwq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x48(%rbp), %rax
               	movsbq	0xa(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x48(%rbp), %rax
               	movzbq	0xb(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	0x10(%rax), %rax
               	sarq	$0x30, %rax
               	addq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x7865, %rax           # imm = 0x7865
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x20, %esi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x60, %esi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0xe5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x11ec, %rax           # imm = 0x11EC
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40, %edi
               	callq	<addr>
               	movl	$0x800000cc, %r11d      # imm = 0x800000CC
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %eax
               	movl	%eax, -0x50(%rbp)
               	movl	-0x50(%rbp), %eax
               	leaq	-0x18(%rbp), %rdi
               	movl	%eax, %esi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
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
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzwq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movsbq	0xa(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xb(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	0x10(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	andq	$0x3, %rax
               	movslq	(%rbx,%rax,4), %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzwq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movsbq	0xa(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xb(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	0x10(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	andq	$0x3, %rax
               	movslq	(%rbx,%rax,4), %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzwq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movsbq	0xa(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xb(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	0x10(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	andq	$0x3, %rax
               	movslq	(%rbx,%rax,4), %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzwq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movsbq	0xa(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xb(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	0x10(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	andq	$0x3, %rax
               	movslq	(%rbx,%rax,4), %rax
               	jmp	<addr>
