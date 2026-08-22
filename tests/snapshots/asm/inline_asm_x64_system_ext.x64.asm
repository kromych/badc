
inline_asm_x64_system_ext.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	leaq	-0x40(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp,%riz)
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rcx, -0x80(%rbp)
               	movq	%rax, -0x78(%rbp)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	invpcid	(%rax), %rbx
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	leaq	-0x40(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rax, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rcx, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	invvpid	(%rax), %rbx
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rax, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rcx, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	invept	(%rax), %rbx
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rax, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	fnclex
               	fldl	(%rbx)
               	fdivl	(%rbx)
               	fmull	(%rbx)
               	fldl	(%rbx)
               	fsubp	%st, %st(1)
               	fistpl	(%rax)
               	wait
               	fninit
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	movl	$0x1, %edx
               	leaq	-0x8(%rbp), %rsi
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rbx, -0x80(%rbp)
               	movq	%rsi, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %rbx
               	movq	-0x68(%rbp), %rcx
               	movzbl	(%rbx,%rcx), %eax
               	movsbq	(%rbx), %rax
               	movzwl	0x2(%rbx), %eax
               	movslq	%eax, %rax
               	movq	-0x78(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rbx
               	xorq	%rax, %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rax, -0x80(%rbp)
               	movq	%rax, -0x78(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rax
               	invlpga
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rsi, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x68(%rbp), %rsi
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	lock
               	cmpxchg16b	(%rsi)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movq	-0x70(%rbp), %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %rax
               	fldl	(%rax)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %rax
               	fstpl	(%rax)
               	movq	-0x90(%rbp), %rax
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %rax
               	stmxcsr	(%rax)
               	movq	-0x90(%rbp), %rax
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %rax
               	ljmpl	*(%rax)
               	movq	-0x90(%rbp), %rax
               	pushw	%fs
               	pushw	%gs
               	popw	%gs
               	popw	%fs
               	movl	$0x2a, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
