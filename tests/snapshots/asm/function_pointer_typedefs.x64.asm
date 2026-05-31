
function_pointer_typedefs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d5 <.text+0xb5>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	cmpq	%r9, %r11
               	jge	0x400271 <.text+0x51>
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	%r9, %r11
               	jle	0x400280 <.text+0x60>
               	movl	$0x1, %eax
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movslq	%edx, %r14
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0xa3(%rip), %rbx       # 0x400257 <.text+0x37>
               	movl	$0x3, %r12d
               	movl	$0x5, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %rdi
               	cmpq	$-0x1, %rdi
               	je	0x400349 <.text+0x129>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r15d
               	movl	$0x2, %r14d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %r12
               	cmpq	$0x1, %r12
               	je	0x400399 <.text+0x179>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %r15d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x4003e3 <.text+0x1c3>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	leaq	-0x1b7(%rip), %r12      # 0x400237 <.text+0x17>
               	movq	%r12, (%r15)
               	leaq	-0x20(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	leaq	-0x1bf(%rip), %rbx      # 0x400247 <.text+0x27>
               	movq	%rbx, (%r12)
               	leaq	-0x20(%rbp), %r15
               	movq	%r15, %rbx
               	addq	$0x10, %rbx
               	leaq	-0x1c8(%rip), %r15      # 0x400257 <.text+0x37>
               	movq	%r15, (%rbx)
               	leaq	-0x20(%rbp), %r12
               	movq	(%r12), %r14
               	movl	$0x2, %r15d
               	movl	$0x3, %r12d
               	movq	%r14, %r11
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	movq	%rax, %rbx
               	cmpq	$0x5, %rbx
               	je	0x400479 <.text+0x259>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %r14
               	movl	$0xa, %r12d
               	movl	$0x4, %ebx
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	cmpq	$0x6, %r15
               	je	0x4004d9 <.text+0x2b9>
               	movl	$0x5, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rbx
               	movq	%rbx, %r15
               	addq	$0x10, %r15
               	movq	(%r15), %r14
               	movl	$0x1, %ebx
               	movl	$0x2, %r15d
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	movq	%rax, %r12
               	cmpq	$-0x1, %r12
               	je	0x400539 <.text+0x319>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x309(%rip), %r14      # 0x400237 <.text+0x17>
               	movl	$0x8, %r15d
               	movl	$0x9, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	callq	0x400287 <.text+0x67>
               	movq	%rax, %rbx
               	cmpq	$0x11, %rbx
               	je	0x400591 <.text+0x371>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
