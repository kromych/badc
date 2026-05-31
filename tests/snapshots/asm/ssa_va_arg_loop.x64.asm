
ssa_va_arg_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ff <.text+0xdf>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	xorq	%r8, %r8
               	movq	%r8, -0x10(%rbp)
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x400261 <.text+0x41>
               	movslq	-0x18(%rbp), %r8
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r8
               	jge	0x4002b6 <.text+0x96>
               	jmp	0x400290 <.text+0x70>
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x400261 <.text+0x41>
               	leaq	-0x10(%rbp), %r8
               	movq	(%r8), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %rdi
               	leaq	0x10(%rdi), %r10
               	movq	%r10, (%r9)
               	movq	(%rdi), %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movq	%rdi, (%r8)
               	jmp	0x400277 <.text+0x57>
               	leaq	-0x8(%rbp), %rdi
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	0x10(%r9), %r11
               	movq	%r11, (%r8)
               	movq	(%r9), %rax
               	leaq	-0x8(%rbp), %r9
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x3, %ebx
               	movl	$0xa, %r12d
               	movl	$0x14, %r14d
               	movl	$0x1e, %r15d
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400237 <.text+0x17>
               	addq	$0x40, %rsp
               	cmpq	$0x3c, %rax
               	je	0x4003a0 <.text+0x180>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ebx
               	movl	$0x1, %r15d
               	movl	$0x2, %r12d
               	movl	$0x3, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x4, %r14d
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	movq	0x48(%rsp), %r10
               	subq	$0x10, %rsp
               	movq	%r10, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400237 <.text+0x17>
               	addq	$0x60, %rsp
               	cmpq	$0xf, %rax
               	je	0x400449 <.text+0x229>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movl	$0x2a, %r14d
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x4002c7 <.text+0xa7>
               	addq	$0x20, %rsp
               	cmpq	$0x2a, %rax
               	je	0x4004aa <.text+0x28a>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
