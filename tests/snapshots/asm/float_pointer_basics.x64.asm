
float_pointer_basics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100e0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4, %r11d
               	movl	$0x8, %r9d
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400329 <.text+0x79>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%r9d, %r9
               	cmpq	$0x8, %r9
               	je	0x400361 <.text+0xb1>
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %ebx
               	movslq	%ebx, %r8
               	shlq	$0x2, %r8
               	movslq	%r8d, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x400657 <malloc>
               	movq	%rax, %r14
               	movslq	%ebx, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400657 <malloc>
               	movq	%rax, %r15
               	movl	$0x3f800000, %ebx       # imm = 0x3F800000
               	movl	%ebx, (%r14)
               	movq	%r14, %rdi
               	addq	$0x4, %rdi
               	movl	$0x40000000, %ebx       # imm = 0x40000000
               	movl	%ebx, (%rdi)
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rsi, (%r15)
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, (%rbx)
               	movslq	(%r14), %rdi
               	cmpq	$0x3f800000, %rdi       # imm = 0x3F800000
               	je	0x400408 <.text+0x158>
               	movl	$0x3, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r14, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rsi
               	cmpq	$0x40000000, %rsi       # imm = 0x40000000
               	je	0x400449 <.text+0x199>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	(%r15), %rsi
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	cmpq	%r11, %rsi
               	je	0x400486 <.text+0x1d6>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	(%rsi), %rdi
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rdi
               	je	0x4004cd <.text+0x21d>
               	movl	$0x6, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40065d <free>
               	movslq	%eax, %rax
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x40065d <free>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
