
ssa_callee_saved_x19.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c7 <.text+0x47>
               	movq	%rax, %rdi
               	callq	*0xfe41(%rip)           # 0x4100d8
               	leaq	0xfe4a(%rip), %r11      # 0x4100e8
               	movslq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x4002c3 <.text+0x43>
               	leaq	0xfe33(%rip), %r11      # 0x4100e8
               	movl	$0x2, %r9d
               	movl	%r9d, (%r11)
               	jmp	0x4002c3 <.text+0x43>
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x4b(%rip), %rbx       # 0x400297 <.text+0x17>
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400457 <__cxa_atexit>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
