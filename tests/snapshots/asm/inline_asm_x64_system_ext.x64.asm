
inline_asm_x64_system_ext.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rbx, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	invpcid	(%rax), %rbx
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rbx
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rbx, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	invvpid	(%rax), %rbx
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rbx
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rcx)
               	popq	%rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rbx, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	invept	(%rax), %rbx
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rbx
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rbx, -0x98(%rbp)
               	movq	%rdx, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	fnclex
               	fldl	(%rbx)
               	fdivl	(%rbx)
               	fmull	(%rbx)
               	fldl	(%rbx)
               	fsubp	%st, %st(1)
               	fistpl	(%rax)
               	wait
               	fninit
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rbx
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x1, %edx
               	leaq	-0x50(%rbp), %rsi
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rbx, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	movq	%rcx, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	movq	-0x80(%rbp), %rbx
               	movq	-0x78(%rbp), %rcx
               	movzbl	(%rbx,%rcx), %eax
               	movsbq	(%rbx), %rax
               	movzwl	0x2(%rbx), %eax
               	movslq	%eax, %rax
               	movq	-0x88(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	movq	-0x90(%rbp), %rbx
               	xorq	%rcx, %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x90(%rbp), %rcx
               	movq	-0x88(%rbp), %rax
               	invlpga
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rdx, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x78(%rbp), %rsi
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rdx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x58(%rbp), %rcx
               	lock
               	cmpxchg16b	(%rsi)
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	movq	-0x90(%rbp), %rdx
               	movq	-0x88(%rbp), %rbx
               	movq	-0x80(%rbp), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	fldl	(%rax)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	fstpl	(%rax)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	stmxcsr	(%rax)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	ljmpl	*(%rax)
               	movq	-0xa0(%rbp), %rax
               	pushw	%fs
               	pushw	%gs
               	popw	%gs
               	popw	%fs
               	movl	$0x2a, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
