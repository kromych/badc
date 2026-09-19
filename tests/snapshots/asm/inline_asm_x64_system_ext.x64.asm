
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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	testl	%edi, %edi
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	$0x0, (%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x28(%rbp,%riz)
               	movl	%ecx, -0x20(%rbp)
               	leaq	-0x40(%rbp), %rax
               	xorl	%ebx, %ebx
               	invpcid	(%rax), %rbx
               	leaq	-0x40(%rbp), %rax
               	xorl	%ebx, %ebx
               	invvpid	(%rax), %rbx
               	movl	%ecx, -0x18(%rbp)
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
               	leaq	-0x40(%rbp), %rax
               	xorl	%ebx, %ebx
               	invept	(%rax), %rbx
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rbx
               	fnclex
               	fldl	(%rbx)
               	fdivl	(%rbx)
               	fmull	(%rbx)
               	fldl	(%rbx)
               	fsubp	%st, %st(1)
               	fistpl	(%rax)
               	wait
               	fninit
               	leaq	-0x10(%rbp), %rbx
               	movl	$0x1, %ecx
               	movzbl	(%rbx,%rcx), %eax
               	movsbq	(%rbx), %rax
               	movzwl	0x2(%rbx), %eax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	invlpga
               	leaq	-0x40(%rbp), %rsi
               	xorl	%eax, %eax
               	xorl	%edx, %edx
               	xorl	%ebx, %ebx
               	xorl	%ecx, %ecx
               	lock
               	cmpxchg16b	(%rsi)
               	leaq	-0x28(%rbp), %rax
               	fldl	(%rax)
               	leaq	-0x28(%rbp), %rax
               	fstpl	(%rax)
               	leaq	-0x20(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	-0x20(%rbp), %rax
               	stmxcsr	(%rax)
               	leaq	-0x30(%rbp), %rax
               	ljmpl	*(%rax)
               	pushw	%fs
               	pushw	%gs
               	popw	%gs
               	popw	%fs
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
