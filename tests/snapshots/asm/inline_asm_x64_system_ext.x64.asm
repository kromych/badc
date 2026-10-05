
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
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, -0x30(%rbp)
               	movl	$0x0, -0x28(%rbp)
               	leaq	-0x10(%rbp), %rax
               	xorl	%ecx, %ecx
               	invpcid	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	xorl	%ecx, %ecx
               	invvpid	(%rax), %rcx
               	movl	$0x0, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x10(%rbp), %rax
               	xorl	%ecx, %ecx
               	invept	(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	fnclex
               	fldl	(%rcx)
               	fdivl	(%rcx)
               	fmull	(%rcx)
               	fldl	(%rcx)
               	fsubp	%st, %st(1)
               	fistpl	(%rax)
               	wait
               	fninit
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x1, %edx
               	movzbl	(%rcx,%rdx), %eax
               	movsbq	(%rcx), %rax
               	movzwl	0x2(%rcx), %eax
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	invlpga
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	xorl	%edx, %edx
               	xorl	%ebx, %ebx
               	xorl	%ecx, %ecx
               	lock
               	cmpxchg16b	(%rsi)
               	leaq	-0x30(%rbp), %rax
               	fldl	(%rax)
               	leaq	-0x30(%rbp), %rax
               	fstpl	(%rax)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	leaq	-0x38(%rbp), %rax
               	ljmpl	*(%rax)
               	pushw	%fs
               	pushw	%gs
               	popw	%gs
               	popw	%fs
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
